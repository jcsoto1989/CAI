using BLL;
using MySql.Data.MySqlClient;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

namespace slnCAI
{
    public partial class login : System.Web.UI.Page
    {
        public static bool ServerConexion;
        public static bool DatabaseScript;
        public static int counter = 0;
        private string bd = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ServerConexion = false;
                DatabaseScript = false;

                try
                {
                    if (SeguridadBLL.ComprobarConexion())
                    {
                        divLogin.Visible = true;
                        divWizard.Visible = false;
                    }
                    else
                    {
                        if (ConfigurationManager.ConnectionStrings["dbCAIConexion"] != null)
                        {
                            string oconexion =
                            ConfigurationManager.ConnectionStrings["dbCAIConexion"].ConnectionString;
                            divWizard.Visible = true;
                            divLogin.Visible = false;
                        }

                    }


                }
                catch (Exception)
                {
                    divWizard.Visible = true;
                    divLogin.Visible = false;
                }

            }
        }

        // Language Change 
        protected override void InitializeCulture()
        {
            if (Request.Form["ddlIdioma_Lgn"] != null)
            {
                String selectedLanguage = Request.Form["ddlIdioma_Lgn"];

                UICulture = selectedLanguage;
                Culture = selectedLanguage;

                Session["language"] = selectedLanguage;
            }
        }

        protected void btnIniciar_Lgn_Click(object sender, EventArgs e)
        {
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtUser_Lgn);
            oCampos.Add(txtPassword_Lgn);

            if (oCampos.Count == revisarCampos(oCampos))
            {
                VerificarUsuario(txtUser_Lgn.Text, txtPassword_Lgn.Text);

            }
        }

        private void VerificarUsuario(string User, string Password)
        {
            ArrayList datosUsuario = new ArrayList();
            try
            {
                if (SeguridadBLL.VerificarUsuario(User))
                {
                    if (SeguridadBLL.VerificarUsuario(User, Password))
                    {
                        foreach (DataRow oRow in SeguridadBLL.getInfoUsuario(User, Password).Rows)
                        {
                            datosUsuario.Add(oRow["numero_Identificacion"].ToString());
                            datosUsuario.Add(oRow["idRol_Usuario"].ToString());
                        }
                        datosUsuario.Add(User);

                        Session["Usuario"] = datosUsuario;
                        Session.Timeout = 30;

                        if (Session["Usuario"] != null)
                        {
                            ArrayList oDatos = (ArrayList)Session["Usuario"];
                            string id = oDatos[0].ToString();
                            SeguridadBLL.UsuarioActivo(1, id);
                        }
                        Response.Redirect("index.aspx");

                    }
                    else
                    {
                        Session["Usuario"] = null;
                        datosUsuario.Clear();
                        ltlMensaje.Text = "<br/><div class='alert alert-danger'>" + GetGlobalResourceObject("Mensajes.language", "UserNoExiste") + "</div>";
                        ltlMensaje.Visible = true;
                    }
                }
                else
                {
                    ltlMensaje.Text = "<br/><div class='alert alert-danger'>" + GetGlobalResourceObject("Mensajes.language", "UserNoExiste") + "</div>";
                    ltlMensaje.Visible = true;
                    counter++;
                    if (counter > 10)
                    {
                        ltlMensaje.Text = "";
                        SeguridadBLL.ConfiguracionInicial("admin", "Administrator", "Male", "", DateTime.Now.ToString("yyyy/MM/dd"), DateTime.Now.ToString("yyyy/MM/dd"), "admin", "CAICR", "System");
                        ltlMensaje.Text = "<br/><div class='alert alert-success'>" + GetGlobalResourceObject("Mensajes.language", "defaultUser") + "</div>";
                        ltlMensaje.Visible = true;
                    }
                }
            }
            catch (Exception)
            {
                ltlMensaje.Text = "<br/><div class='alert alert-danger'>" + GetGlobalResourceObject("Mensajes.language", "baseDatosError") + "</div>";
                ltlMensaje.Visible = true;
            }
        }

        private void LimpiarCampos(ControlCollection page)
        {
            foreach (Control ctrl in page)
            {
                if (ctrl is TextBox)
                {
                    TextBox txt = (TextBox)ctrl;

                    if (!txt.Text.Trim().Equals(""))
                    {
                        txt.Text = "";
                        txt.BackColor = Color.White;
                    }
                    else
                    {
                        txt.Text = "";
                        txt.BackColor = Color.White;
                    }
                }
                else
                {
                    if (ctrl is DropDownList)
                    {
                        DropDownList ddl = (DropDownList)ctrl;
                        if (ddl.SelectedIndex != -1)
                        {
                            ddl.SelectedIndex = -1;
                            ddl.BackColor = Color.White;
                        }
                        else
                        {
                            ddl.SelectedIndex = -1;
                            ddl.BackColor = Color.White;
                        }
                    }
                    else
                    {
                        if (ctrl is CheckBoxList)
                        {
                            CheckBoxList chk = (CheckBoxList)ctrl;
                            foreach (ListItem oItem in chk.Items)
                            {
                                oItem.Selected = false;
                            }
                        }
                    }

                }
            }
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

        private void AddUpdateConnectionString(string name, string server, string usuario, string password, string database)
        {
            bool isNew = false;
            string path = Server.MapPath("~/Web.Config");
            XmlDocument doc = new XmlDocument();
            doc.Load(path);
            XmlNodeList list = doc.DocumentElement.SelectNodes(string.Format("connectionStrings/add[@name='{0}']", name));
            XmlNode node;
            isNew = list.Count == 0;
            if (isNew)
            {
                node = doc.CreateNode(XmlNodeType.Element, "add", null);
                XmlAttribute attribute = doc.CreateAttribute("name");
                attribute.Value = name;
                node.Attributes.Append(attribute);

                attribute = doc.CreateAttribute("connectionString");
                attribute.Value = "";
                node.Attributes.Append(attribute);

                attribute = doc.CreateAttribute("providerName");
                attribute.Value = "MySql.Data.MySqlClient";
                node.Attributes.Append(attribute);
            }
            else
            {
                node = list[0];
            }

            bd = database;

            string conString = node.Attributes["connectionString"].Value;
            MySqlConnectionStringBuilder bdBuilder = new MySqlConnectionStringBuilder(conString);
            bdBuilder.Server = server;
            bdBuilder.Database = database;
            bdBuilder.IntegratedSecurity = false;
            bdBuilder.UserID = usuario;
            bdBuilder.Password = password;
            node.Attributes["connectionString"].Value = bdBuilder.ConnectionString;
            if (isNew)
            {
                doc.DocumentElement.SelectNodes("connectionString")[0].AppendChild(node);
            }
            doc.Save(path);
        }

        protected void btnSaveServer_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtDBServer);
            oCampos.Add(txtDBuser);
            oCampos.Add(txtDBPassword);

            if (revisarCampos(oCampos) == oCampos.Count)
            {
                string name, server, usuario, password, database;

                name = "dbCAIConexion";
                server = txtDBServer.Text;
                usuario = txtDBuser.Text;
                password = txtDBPassword.Text;
                database = "db_cai_v2";
                try
                {
                    AddUpdateConnectionString(name, server, usuario, password, database);
                    ServerConexion = true;
                    btnSaveServer.Enabled = false;

                    string tab = GetGlobalResourceObject("Mensajes.language", "cnxString").ToString();
                    string message = "";
                    showMessage(ltlMsg_Conexion, tab + message, 1);
                }
                catch (Exception)
                {
                    string tab = GetGlobalResourceObject("Mensajes.language", "baseDatosError").ToString();
                    string message = "";
                    showMessage(ltlMsg_Conexion, tab + message, 2);
                }
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Conexion, tab + message, 2);
            }
        }

        protected void btnUploadScript_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (rdbInitialScript.Checked)
            {
                try
                {
                    SeguridadBLL.restaurarBackup(Server.MapPath("~/Archivos/Initialize/Esquema(Tablas).sql"), "sys");
                    SeguridadBLL.restaurarBackup(Server.MapPath("~/Archivos/Initialize/ProcedimientosAlmacenados.sql"), bd);
                    SeguridadBLL.restaurarBackup(Server.MapPath("~/Archivos/Initialize/Triggers.sql"), bd);
                    SeguridadBLL.restaurarBackup(Server.MapPath("~/Archivos/Initialize/Insert.sql"), bd);

                    string tab = GetGlobalResourceObject("Mensajes.language", "initialScript").ToString();
                    string message = "";
                    showMessage(ltlMsg_Db, tab + message, 1);

                    DatabaseScript = true;
                }
                catch (Exception ex)
                {
                    string tab = GetGlobalResourceObject("Mensajes.language", "initialScriptError").ToString();
                    string message = "--- ";
                    showMessage(ltlMsg_Db, tab + message, 2);
                }
            }
            else
            {
                if (rdbBackup.Checked)
                {
                    if (flupScript.HasFile)
                    {
                        if (Path.GetExtension(flupScript.FileName).Equals(".iac"))
                        {
                            try
                            {
                                flupScript.SaveAs(Server.MapPath("~/Archivos/") + flupScript.FileName);
                                Decrypt(Server.MapPath("~/Archivos/enc" + flupScript.FileName), Server.MapPath("~/Archivos/" + flupScript.FileName));
                                File.Delete(Server.MapPath("~/Archivos/enc" + flupScript.FileName));
                                SeguridadBLL.restaurarBackup(Server.MapPath("~/Archivos/") + flupScript.FileName);

                                string tab = GetGlobalResourceObject("Mensajes.language", "restaurar").ToString();
                                string message = "";
                                showMessage(ltlMsg_Db, tab + message, 1);
                            }
                            catch (Exception)
                            {
                                string tab = GetGlobalResourceObject("Mensajes.language", "restaurarError").ToString();
                                string message = "";
                                showMessage(ltlMsg_Db, tab + message, 2);
                            }

                        }
                        else
                        {
                            string tab = GetGlobalResourceObject("Mensajes.language", "extError").ToString();
                            string message = "";
                            showMessage(ltlMsg_Db, tab + message, 2);
                        }
                    }
                    else
                    {
                        string tab = GetGlobalResourceObject("Mensajes.language", "uploadFile").ToString();
                        string message = "";
                        showMessage(ltlMsg_Db, tab + message, 2);
                    }
                }
            }

        }

        protected void btnFinishConfig_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtID_User);
            oCampos.Add(txtName_User);
            oCampos.Add(ddlSex_User);
            oCampos.Add(txtPuesto_User);
            oCampos.Add(txtBirthDay_User);
            oCampos.Add(txtRecruitment_user);
            oCampos.Add(txtUser_User);
            oCampos.Add(txtPsw_User);

            if (revisarCampos(oCampos) == oCampos.Count)
            {
                string id, nombre, sexo, puesto, user, password;
                string fechaNacimiento, fechaIngeso;

                id = txtID_User.Text;
                nombre = txtName_User.Text;
                sexo = ddlSex_User.SelectedValue;
                puesto = txtPuesto_User.Text;
                user = txtUser_User.Text;
                password = txtPsw_User.Text;
                fechaNacimiento = Convert.ToDateTime(txtBirthDay_User.Text).ToString("yyyy/MM/dd");
                fechaIngeso = Convert.ToDateTime(txtRecruitment_user.Text).ToString("yyyy/MM/dd");

                try
                {
                    if (DatabaseScript == true && ConfigurationManager.ConnectionStrings["dbCAIConexion"] != null)
                    {
                        try
                        {
                            SeguridadBLL.ConfiguracionInicial(id, nombre, sexo, puesto, fechaNacimiento, fechaIngeso, user, password, id);

                            string tab = GetGlobalResourceObject("Mensajes.language", "guardarCorrecto").ToString();
                            string message = "";
                            showMessage(ltlMsg_User, tab + message, 1);

                            string ToRedirectURL = "login.aspx";
                            Response.AppendHeader("REFRESH", "1;URL=" + ToRedirectURL);
                        }
                        catch (Exception ex)
                        {
                            string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                            string message = "--- ";
                            showMessage(ltlMsg_User, tab + message, 2);
                        }
                    }
                    else
                    {
                        string tab = GetGlobalResourceObject("Mensajes.language", "baseDatosError").ToString();
                        string message = "";
                        showMessage(ltlMsg_User, tab + message, 2);
                    }

                }
                catch (Exception ex)
                {
                    string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                    string message = "--- ";
                    showMessage(ltlMsg_User, tab + message, 2);
                }

            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_User, tab + message, 2);
            }

        }

        private void Decrypt(string inputFilePath, string outputfilePath)
        {
            try
            {
                string EncryptionKey = "#YpDM8vwi#oQ6";
                using (Aes encryptor = Aes.Create())
                {
                    Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                    encryptor.Key = pdb.GetBytes(32);
                    encryptor.IV = pdb.GetBytes(16);
                    using (FileStream fsInput = new FileStream(inputFilePath, FileMode.Open))
                    {
                        using (CryptoStream cs = new CryptoStream(fsInput, encryptor.CreateDecryptor(), CryptoStreamMode.Read))
                        {
                            using (FileStream fsOutput = new FileStream(outputfilePath, FileMode.Create))
                            {
                                int data;
                                while ((data = cs.ReadByte()) != -1)
                                {
                                    fsOutput.WriteByte((byte)data);
                                }
                            }
                        }
                    }
                }
            }
            catch (Exception)
            {
                File.Delete(inputFilePath);
                File.Delete(outputfilePath);
            }
        }

        protected void showMessage(Literal ltl, string message, int tipo)
        {
            switch (tipo)
            {
                case 1:
                    string divExito1 = "<br/><div class='alert alert-success alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
                    string divExito2 = "</div>";
                    ltl.Text = divExito1 + message + divExito2;
                    ltl.Visible = true;
                    break;

                case 2:
                    string divError1 = "<br/><div class='alert alert-danger  alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
                    string divError2 = "</div>";
                    ltl.Text = divError1 + message + divError2;
                    ltl.Visible = true;
                    break;

                case 3:
                    string divWarn1 = "<br/><div class='alert alert-warning  alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
                    string divWarn2 = "</div>";
                    ltl.Text = divWarn1 + message + divWarn2;
                    ltl.Visible = true;
                    break;

                default:
                    break;
            }
            /*
            StringBuilder builder = new StringBuilder();

            builder.Append("window.setTimeout(function () {");
            builder.Append("$('.alert').fadeTo(1, 0).slideUp(400, function () {");
            builder.Append("$(this).remove();");
            builder.Append("});");
            builder.Append("}, 5000);");

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", builder.ToString(), true);*/
        }

        private void LimpiarMensajes()
        {
            ltlMsg_Conexion.Text = "";
            ltlMsg_Db.Text = "";
            ltlMsg_User.Text = "";
        }

    }
}