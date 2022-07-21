using BLL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace slnCAI
{
    public partial class Site : System.Web.UI.MasterPage
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Usuario"] != null)
                {
                    ArrayList oDatos = (ArrayList)Session["Usuario"];
                    llenarMenuPrincipal(oDatos[1].ToString());
                    GetDatosUsuario(oDatos[0].ToString());
                    SetupServer();
                }
                else
                {
                    Response.Redirect("Login.aspx");
                }

            }
        }

        private void GetDatosUsuario(string idUsuario)
        {
            try
            {
                foreach (DataRow oRow in iacBLL.getColabor(idUsuario).Rows)
                {
                    int Final = oRow["nombre_Completo"].ToString().IndexOf(' ');
                    imgUsuario.ImageUrl = oRow["Ruta_Foto"].ToString();
                    imgUsuario1.ImageUrl = imgUsuario.ImageUrl;

                    if (string.IsNullOrEmpty(imgUsuario.ImageUrl))
                    {
                        imgUsuario.ImageUrl = "~/Imagenes/IACLogo.jpg";
                        imgUsuario1.ImageUrl = imgUsuario.ImageUrl;
                    }

                    if (Final == -1)
                    {
                        lblNombre.Text = oRow["nombre_Completo"].ToString().Substring(0);
                        lblNombre1.Text = lblNombre.Text;
                    }
                    else
                    {
                        lblNombre.Text = oRow["nombre_Completo"].ToString().Substring(0, Final);
                        lblNombre1.Text = lblNombre.Text;
                    }
                }

                try
                {
                    ltlTitulo1.Text = "IAC-" + IndexBLL.getPais();
                }
                catch (Exception)
                {
                    ltlTitulo1.Text = "I A C";
                }

            }
            catch (Exception)
            {

                throw;
            }
        }

        private void llenarMenuPrincipal(string idRol)
        {
            StringBuilder oMenu = new StringBuilder();
            List<String> oGlyphicons = new List<string>();
            oGlyphicons.Add("glyphicon-dashboard");
            oGlyphicons.Add("glyphicon-education");
            oGlyphicons.Add("glyphicon glyphicon-wrench");
            oGlyphicons.Add("glyphicon-cog");
            oGlyphicons.Add("glyphicon-lock");
            oGlyphicons.Add("glyphicon-list-alt");
            oGlyphicons.Add("glyphicon-info-sign");

            try
            {
                foreach (DataRow oRow in SeguridadBLL.getMenu(Convert.ToInt32(idRol), "Principal").Rows)
                {

                    if (Convert.ToInt32(oRow["idpermiso"].ToString()) != 7)
                    {
                        oMenu.Append("<li><a href='");
                        oMenu.Append(oRow["url"].ToString());
                        oMenu.Append("'><span class='glyphicon ");
                        oMenu.Append(oGlyphicons[Convert.ToInt32(oRow["idpermiso"].ToString()) - 1]);
                        oMenu.Append("'></span> ");
                        oMenu.Append(GetGlobalResourceObject("site.language", oRow["permiso"].ToString()).ToString());
                        oMenu.Append("</a></li>");
                    }
                    else
                    {
                        oMenu.Append("<li><a href='");
                        oMenu.Append(oRow["url"].ToString());
                        oMenu.Append("' data-toggle='modal'><span class='glyphicon ");
                        oMenu.Append(oGlyphicons[Convert.ToInt32(oRow["idpermiso"].ToString()) - 1]);
                        oMenu.Append("'></span> ");
                        oMenu.Append(GetGlobalResourceObject("site.language", oRow["permiso"].ToString()).ToString());
                        oMenu.Append("</a></li>");
                    }

                }
                ltlMenuMobile.Text = oMenu.ToString();
                ltlMenuCompleto.Text = oMenu.ToString();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btnCerrarSesion_Click(object sender, EventArgs e)
        {
            if (Session["Usuario"] != null)
            {
                ArrayList oDatos = (ArrayList)Session["Usuario"];
                string id = oDatos[1].ToString();
                SeguridadBLL.UsuarioActivo(0, id);
            }
            Session["Usuario"] = null;
            Response.Redirect("Login.aspx");
        }

        protected void btnChangePass_Click(object sender, EventArgs e)
        {
            StringBuilder sbChangePass = new StringBuilder();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtOldPass);
            oCampos.Add(txtNewPass);
            oCampos.Add(txtConfirmPass);

            String oldPass = txtOldPass.Text;
            string newPass = txtNewPass.Text;
            string confirPass = txtConfirmPass.Text;


            ArrayList oDatos = (ArrayList)Session["Usuario"];


            if (oCampos.Count == revisarCampos(oCampos))
            {
                if (SeguridadBLL.VerificarUsuario(oDatos[2].ToString(), txtOldPass.Text.Trim()))
                {
                    if (txtNewPass.Text.Trim().Equals(txtConfirmPass.Text.Trim()))
                    {
                        ltlMessagePass.Text = "";

                        if (SeguridadBLL.CambiarContrasenna(oDatos[0].ToString(), txtNewPass.Text.Trim(), oDatos[0].ToString()) >= 1)
                        {
                            sbChangePass.Append("<div class='alert alert-success'>");
                            sbChangePass.Append(GetGlobalResourceObject("site.language", "passChanged").ToString() + ". ");
                            sbChangePass.Append("</div>");
                            ltlMessagePass.Text = sbChangePass.ToString();
                            txtOldPass.Text = "";
                            txtNewPass.Text = "";
                            txtConfirmPass.Text = "";
                            Response.Redirect(Request.RawUrl);
                        }
                        else
                        {
                            sbChangePass.Append("<div class='alert alert-danger'>");
                            sbChangePass.Append(GetGlobalResourceObject("site.language", "passNoChanged").ToString() + ". ");
                            sbChangePass.Append("</div>");
                            ltlMessagePass.Text = sbChangePass.ToString();
                        }


                    }
                    else
                    {
                        txtNewPass.BackColor = Color.LightPink;
                        txtConfirmPass.BackColor = Color.LightPink;

                        sbChangePass.Append("<div class='alert alert-danger'>");
                        sbChangePass.Append(GetGlobalResourceObject("site.language", "noMatch").ToString() + ". ");
                        sbChangePass.Append("</div>");
                        ltlMessagePass.Text = sbChangePass.ToString();
                    }
                }
                else
                {
                    txtOldPass.BackColor = Color.LightPink;

                    sbChangePass.Append("<div class='alert alert-danger'>");
                    sbChangePass.Append(GetGlobalResourceObject("site.language", "passInvalid").ToString() + ". ");
                    sbChangePass.Append("</div>");
                    ltlMessagePass.Text = sbChangePass.ToString();
                }
            }
            else
            {
                sbChangePass.Append("<div class='alert alert-danger'>");
                sbChangePass.Append(GetGlobalResourceObject("site.language", "allTxt").ToString() + ". ");
                sbChangePass.Append("</div>");
                ltlMessagePass.Text = sbChangePass.ToString();
            }

            txtOldPass.Attributes.Add("value", oldPass);
            txtNewPass.Attributes.Add("value", newPass);
            txtConfirmPass.Attributes.Add("value", confirPass);
        }

        private int revisarCampos(ArrayList campos)
        {
            int camposLlenos = 0;
            foreach (Control ctrl in campos)
            {
                if (ctrl is TextBox)
                {
                    TextBox txt = (TextBox)ctrl;

                    if (txt.Text.Trim().Equals(""))
                    {
                        txt.BackColor = Color.LightPink;
                    }
                    else
                    {
                        txt.BackColor = Color.LightGreen;
                        camposLlenos++;
                    }
                }
                else
                {
                    if (ctrl is DropDownList)
                    {
                        DropDownList ddl = (DropDownList)ctrl;
                        if (ddl.SelectedIndex != -1)
                        {
                            ddl.BackColor = Color.LightGreen;
                            camposLlenos++;
                        }
                        else
                        {
                            ddl.BackColor = Color.LightPink;
                        }
                    }

                }
            }

            return camposLlenos;
        }



        /// SOcket
        public static byte[] buffer { set; get; }
        public static List<Socket> lstClientes { set; get; }
        public static Socket serverSocket { set; get; }

        public static List<string> lstIP { set; get; }
        public static List<string> lstPC { set; get; }
        public static List<string> lstlog { set; get; }


        public void SetupServer()
        {
            lstIP = new List<string>();
            lstPC = new List<string>();
            lstlog = new List<string>();
            buffer = new byte[1024];
            lstClientes = new List<Socket>();
            if (serverSocket == null)
            {
                serverSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "notifyMe('Prueba','Configurando Servidor...')", true);
                lstlog.Add("Configurando Servidor...");
                //Console.WriteLine("Configurando Servidor...");
                serverSocket.Bind(new IPEndPoint(IPAddress.Any, 100));
                serverSocket.Listen(2);
                serverSocket.BeginAccept(new AsyncCallback(AcceptCallback), null);
            }

        }

        public void AcceptCallback(IAsyncResult ar)
        {
            Socket socket = serverSocket.EndAccept(ar);
            lstClientes.Add(socket);
            string ip = "" + IPAddress.Parse(((IPEndPoint)socket.RemoteEndPoint).Address.ToString());
            string funcion = "notifyMe('Prueba','" + ip + "')";

            //Page.ClientScript.RegisterStartupScript(this.GetType(), "AnyValue", "notifyMe(Prueba1," + ip + ");", true);
            ScriptManager.RegisterClientScriptBlock(Page, typeof(string), "prueba", "notifyMe('Prueba1','esto es una prueba');", true);

            lstIP.Add(ip);
            //Console.WriteLine("Cliente Conectado");
            socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, new AsyncCallback(ReceiveCallback), socket);
            serverSocket.BeginAccept(new AsyncCallback(AcceptCallback), null);
        }

        public static void ReceiveCallback(IAsyncResult ar)
        {
            Socket socket = (Socket)ar.AsyncState;

            try
            {
                int received = socket.EndReceive(ar);
                byte[] databuf = new byte[received];
                Array.Copy(buffer, databuf, received);

                string text = Encoding.ASCII.GetString(databuf);



                if (text.ToLower() == "get time")
                {
                    Console.WriteLine("Text received: " + text);
                    SendText(DateTime.Now.ToLongTimeString(), socket);
                }
                else
                {
                    if (text.ToLower().Substring(0, 2) == "pc")
                    {
                        lstPC.Add(text.Substring(3));
                        lstlog.Add(text.Substring(3) + " Conectada");
                        //Console.WriteLine();
                    }
                    else
                    {
                        SendText("Invalid Request", socket);
                    }

                }
                socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, new AsyncCallback(ReceiveCallback), socket);
            }
            catch (Exception)
            {
                lstlog.Add("PC desconectada");
                lstIP.Remove("" + IPAddress.Parse(((IPEndPoint)socket.RemoteEndPoint).Address.ToString()));
                //Console.WriteLine("client disconnected");
                socket.Close();
                socket.Dispose();
            }
        }

        public static void SendText(string text, Socket socket)
        {
            byte[] data = Encoding.ASCII.GetBytes(text);
            socket.BeginSend(data, 0, data.Length, SocketFlags.None, new AsyncCallback(SendCallback), socket);
        }

        public static void SendCallback(IAsyncResult AR)
        {
            Socket socket = (Socket)AR.AsyncState;
            socket.EndSend(AR);
        }

    }
}