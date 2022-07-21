 using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using Entidad;
using System.Text;

namespace slnCAI
{
    public partial class IAC : System.Web.UI.Page
    {
        List<Tarea_Colaborador> oLstTareas;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Usuario"] != null)
                {
                    ArrayList oDatos = (ArrayList)Session["Usuario"];
                    crearTabs(oDatos[1].ToString());
                }

            }
        }

        private void crearTabs(string idRol)
        {
            StringBuilder oTabs = new StringBuilder();

            try
            {
                DataTable dt = SeguridadBLL.getMenu(Convert.ToInt32(idRol), "IAC");
                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow oRow in dt.Rows)
                    {
                        oTabs.Append("<li><a data-toggle='tab' href='");
                        oTabs.Append(oRow["url"].ToString());

                        oTabs.Append("'>");
                        oTabs.Append(GetGlobalResourceObject("iac.language", oRow["permiso"].ToString()).ToString());
                        oTabs.Append("</a></li>");

                        String idTab = oRow["url"].ToString().Substring(1) + 1;

                        switch (idTab)
                        {

                            case "tabInstitucion1":
                                tabInstitucion1.Visible = true;
                                LLenarInfoIns(); //1
                                fillddlColaborator_Ins(); //2
                                fillddlCountries(); //3
                                break;

                            case "tabIAC1":
                                tabIAC1.Visible = true;
                                LlenarInfoIac();//1
                                break;

                            case "tabColaboradores1":
                                tabColaboradores1.Visible = true;
                                llenarGrvColabor();//1
                                fillddlPuesto(); //2
                                oLstTareas = new List<Tarea_Colaborador>();
                                Session["Files"] = new ArrayList();
                                Session["Tarea"] = new List<Tarea_Colaborador>();

                                break;
                            default:
                                break;
                        }

                    }
                    hfTab.Value = dt.Rows[0]["url"].ToString().Substring(1);
                    ltlTabs.Text = oTabs.ToString();
                }
                else
                {
                    IacPage.Visible = false;
                    //divMensaje.Visible = true;
                }

            }
            catch (Exception)
            {

            }
        }

        //INSTITUTION TAB
        protected void LLenarInfoIns()
        {
            try
            {

                foreach (DataRow row in iacBLL.CancelarIns().Rows)
                {
                    hddFIdInst_Ins.Value = row[0].ToString();
                    txtNombre_Ins.Text = row[1].ToString();
                    txtSede_Ins.Text = row[2].ToString();
                    ddlPais_Ins.SelectedValue = row[3].ToString();
                    txtTel_Ins.Text = row[4].ToString();
                    txtDireccion_Ins.Text = row[5].ToString();
                    ddlNombeRe_Ins.SelectedValue = row[6].ToString();
                    imgLgIns_Ins.ImageUrl = row[7].ToString();
                    imgLgDepar_Ins.ImageUrl = row[8].ToString();

                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 2);
            }
        }
        private void fillddlColaborator_Ins()
        {
            try
            {
                ddlNombeRe_Ins.DataSource = iacBLL.getnombre();
                ddlNombeRe_Ins.DataValueField = "numero_Identificacion";
                ddlNombeRe_Ins.DataTextField = "nombre_Completo";
                ddlNombeRe_Ins.DataBind();

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 2);

            }
        }
        protected void fillddlCountries()
        {
            try
            {
                ddlPais_Ins.DataSource = iacBLL.getCountries();
                ddlPais_Ins.DataTextField = "nombre";
                ddlPais_Ins.DataValueField = "idPais";
                ddlPais_Ins.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 2);
            }
        }
        protected void btnUploadInstitution_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                Session["ImageIns"] = flupLgIns_Ins.PostedFile;
                Stream fs = flupLgIns_Ins.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                byte[] bytes = br.ReadBytes((Int32)fs.Length);
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                imgLgIns_Ins.ImageUrl = "data:image/png;base64," + base64String;

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "subirArchivo").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 3);
            }

        }
        protected void btnUpldLgDepart_Ins_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                Session["ImageDepar"] = fluLgDepar_Ins.PostedFile;
                Stream fs = fluLgDepar_Ins.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                byte[] bytes = br.ReadBytes((Int32)fs.Length);
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                imgLgDepar_Ins.ImageUrl = "data:image/png;base64," + base64String;

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "subirArchivo").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 3);
            }
        }
        protected void btnGuardar_Ins_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtNombre_Ins);
            olstCampos.Add(ddlPais_Ins);
            olstCampos.Add(ddlNombeRe_Ins);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarIns();
                LLenarInfoIns();
                //Response.Redirect(Request.RawUrl);
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 2);
            }
        }
        protected void GuardarIns()
        {
            try
            {
                Iac_ins oIac = new Iac_ins();
                try
                {
                    oIac.codigo_institucion = Convert.ToInt32(hddFIdInst_Ins.Value);
                }
                catch (Exception)
                {
                    oIac.codigo_institucion = 0;
                }
                oIac.nombre_Institucion = txtNombre_Ins.Text;
                String Pais_ins = Convert.ToString(ddlPais_Ins.SelectedItem.Value);

                oIac.nombre_Departamento = txtSede_Ins.Text;
                oIac.idpais = Convert.ToInt32(Pais_ins);
                oIac.telefono_Institucion = txtTel_Ins.Text;
                oIac.direccion = txtDireccion_Ins.Text;
                oIac.idRepresentante = ddlNombeRe_Ins.Text;



                if (Session["ImageIns"] != null)
                {
                    HttpPostedFile postedFileIns = (HttpPostedFile)Session["ImageIns"];
                    postedFileIns.SaveAs(Server.MapPath("~/Archivos/") + Path.GetFileName(postedFileIns.FileName));
                    oIac.rutaLogo_Institucion = "~/Archivos/" + Path.GetFileName(postedFileIns.FileName);
                }
                else
                {
                    oIac.rutaLogo_Institucion = imgLgIns_Ins.ImageUrl;
                }

                if (Session["ImageDepar"] != null)
                {
                    HttpPostedFile postedFileIns = (HttpPostedFile)Session["ImageDepar"];
                    postedFileIns = (HttpPostedFile)Session["ImageDepar"];
                    postedFileIns.SaveAs(Server.MapPath("~/Archivos/") + Path.GetFileName(postedFileIns.FileName));
                    oIac.rutaLogo_departamento = "~/Archivos/" + Path.GetFileName(postedFileIns.FileName);
                }
                else
                {
                    oIac.rutaLogo_departamento = imgLgDepar_Ins.ImageUrl;
                }

                ArrayList oDatos = (ArrayList)Session["Usuario"];
                iacBLL.GuardarIacIns(oIac, oDatos[0].ToString());


                string tab = GetGlobalResourceObject("iac.language", "datosins").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsgIns, tab + message, 1);

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 2);
            }
        }
        protected void btnCancelar_Ins_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LLenarInfoIns();
        }


        //INFORMATION IAC TAB
        protected void LlenarInfoIac()
        {
            try
            {
                foreach (DataRow row in iacBLL.CancelarIac().Rows)
                {
                    txtNombre_IAC.Text = row[1].ToString();
                    txtDireccion_IAC.Text = row[2].ToString();
                    txtEmail_IAC.Text = row[3].ToString();
                    txtTel1_IAC.Text = row[4].ToString();
                    txtExt1_IAC.Text = row[5].ToString();
                    txtTel2_IAC.Text = row[6].ToString();
                    txtExt2_IAC.Text = row[7].ToString();
                    txtTel3_IAC.Text = row[8].ToString();
                    txtExt3_IAC.Text = row[9].ToString();
                    imgLg_IAC.ImageUrl = row[10].ToString();
                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgIAC, tab + message, 2);
            }
        }
        protected void btnUpdlLg_IAC_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                Session["ImageIAC"] = fluLg_IAC.PostedFile;
                Stream fs = fluLg_IAC.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                byte[] bytes = br.ReadBytes((Int32)fs.Length);
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                imgLg_IAC.ImageUrl = "data:image/png;base64," + base64String;
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "subirArchivo").ToString();
                string message = "";
                showMessage(ltlMsgIAC, tab + message, 3);
            }
        }
        protected void btnGuardar_IAC_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtNombre_IAC);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarIac();
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsgIAC, tab + message, 2);
            }
        }
        protected void GuardarIac()
        {
            try
            {
                Iac oIac = new Iac();

                oIac.idIAC = 1;
                oIac.nombre = txtNombre_IAC.Text;
                oIac.direccion = txtDireccion_IAC.Text;
                oIac.email = txtEmail_IAC.Text;
                oIac.telefono1 = txtTel1_IAC.Text;
                oIac.ext1 = txtExt1_IAC.Text;
                oIac.telefono2 = txtTel2_IAC.Text;
                oIac.ext2 = txtExt2_IAC.Text;
                oIac.telefono3 = txtTel3_IAC.Text;
                oIac.ext3 = txtExt3_IAC.Text;


                if (Session["ImageIAC"] != null)
                {
                    HttpPostedFile postedFileIns = (HttpPostedFile)Session["ImageIAC"];
                    postedFileIns.SaveAs(Server.MapPath("~/Archivos/") + Path.GetFileName(postedFileIns.FileName));
                    oIac.rutaLogo = "~/Archivos/" + Path.GetFileName(postedFileIns.FileName);
                }
                else
                {
                    oIac.rutaLogo = imgLg_IAC.ImageUrl;
                }

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                iacBLL.GuardarIac(oIac, oDatos[0].ToString());

                string tab = GetGlobalResourceObject("iac.language", "datosiac").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();

                showMessage(ltlMsgIAC, tab + message, 1);

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsgIAC, tab + message, 2);
            }
        }
        protected void btnCancelar_IAC_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LlenarInfoIac();
        }


        //COLABORATOR TAB

        private void llenarGrvColabor()
        {
            try
            {
                grvColaboradores_Col.DataSource = iacBLL.getColabor();
                grvColaboradores_Col.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgIAC, tab + message, 2);
            }
        }
        private void fillddlPuesto()
        {
            try
            {
                ddlPuesto_Col.DataSource = PuestoBLL.obtenerPuestos();
                ddlPuesto_Col.DataValueField = "idPuesto";
                ddlPuesto_Col.DataTextField = "puesto";
                ddlPuesto_Col.DataBind();

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgIAC, tab + message, 2);
            }
        }

        /****************************************************************************/
        protected void btnUpdFotoCol_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                Session["ImageCol"] = flupFoto_Col.PostedFile;
                Stream fs = flupFoto_Col.PostedFile.InputStream;
                BinaryReader br = new BinaryReader(fs);
                byte[] bytes = br.ReadBytes((Int32)fs.Length);
                string base64String = Convert.ToBase64String(bytes, 0, bytes.Length);
                imgFoto_Col.ImageUrl = "data:image/png;base64," + base64String;
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "subirArchivo").ToString();
                string message = "";
                showMessage(ltlMsgCol, tab + message, 3);
            }
        }
        protected void btnAgregarTa_Col_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                ArrayList oCampos = new ArrayList();

                oCampos.Add(txtID_Col);
                oCampos.Add(txtTarea_Col);

                if (lstTarea_Col.SelectedIndex == 0 && String.IsNullOrEmpty(txtTarea_Col.Text))
                {
                    lstTarea_Col.Items.RemoveAt(lstTarea_Col.SelectedIndex);
                }
                else
                {
                    if (revisarCampos(oCampos) == oCampos.Count)
                    {
                        Tarea_Colaborador oTarea = new Tarea_Colaborador(txtID_Col.Text, txtTarea_Col.Text);
                        List<Tarea_Colaborador> oTareas = (List<Tarea_Colaborador>)Session["Tarea"];
                        oTareas.Add(oTarea);

                        ListItem oItem = new ListItem(oTarea.ToString());

                        if (lstTarea_Col.SelectedIndex != 0)
                        {
                            lstTarea_Col.Items.Add(oItem);
                            txtTarea_Col.Text = "";
                            txtTarea_Col.BackColor = Color.White;
                            txtID_Col.BackColor = Color.White;
                        }
                        else
                        {
                            lstTarea_Col.Items.RemoveAt(lstTarea_Col.SelectedIndex);
                            lstTarea_Col.Items.Add(oItem);
                            txtTarea_Col.Text = "";
                            txtTarea_Col.BackColor = Color.White;
                            txtID_Col.BackColor = Color.White;

                        }
                    }
                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "subirArchivo").ToString();
                string message = "";
                showMessage(ltlMsgCol, tab + message, 3);
            }


        }
        protected void btnUpldFile_Col_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                if (lstArchivo_Col.SelectedIndex != 0)
                {
                    ArrayList oFiles = (ArrayList)Session["Files"];
                    oFiles.Add(FlupFile_Col.PostedFile);

                    if (oFiles != null)
                    {
                        string folderPath = Server.MapPath("~/Archivos/" + txtID_Col.Text + "/");
                        if (!Directory.Exists(folderPath))
                        {
                            //If Directory (Folder) does not exists. Create it.
                            Directory.CreateDirectory(folderPath);
                        }

                        foreach (HttpPostedFile oFile in oFiles)
                        {
                            oFile.SaveAs(folderPath + oFile.FileName);
                            lstArchivo_Col.Items.Add(oFile.FileName);
                        }
                    }
                }
                else
                {
                    eliminarArchivo();
                    btnUpldFile_Col.Text = (string)GetGlobalResourceObject("iac.language", "subir");
                    btnUpldFile_Col.CssClass = "btn btn-info btn-sm";
                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "subirArchivo").ToString();
                string message = "";
                showMessage(ltlMsgCol, tab + message, 3);
            }



        }
        protected void btnGuardar_Col_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtID_Col);
            olstCampos.Add(txtNombre_Col);
            olstCampos.Add(ddlPuesto_Col);
            olstCampos.Add(txtFechaIng_Col);
            olstCampos.Add(ddlEstado_Col);
            olstCampos.Add(ddlSexo_Col);
            olstCampos.Add(txtFechaNac_Col);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarCol();
                LimpiarCampos(tabColaboradores1.Controls);
                imgFoto_Col.ImageUrl = "~/Imagenes/logo.png";
                lstArchivo_Col.Items.Clear();
                lstTarea_Col.Items.Clear();
                oLstTareas = new List<Tarea_Colaborador>();
                llenarGrvColabor();
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsgCol, tab + message, 2);
            }
        }
        /****************************************************************************/
        protected void GuardarCol()
        {
            try
            {
                Iac_col oIac = new Iac_col();
                oIac.numero_Identificacion = txtID_Col.Text;
                String IdPuesto = Convert.ToString(ddlPuesto_Col.SelectedItem.Value);
                String Sexop = Convert.ToString(ddlSexo_Col.SelectedItem.Value);

                oIac.nombre_Completo = txtNombre_Col.Text;
                oIac.idPuesto = Convert.ToInt32(IdPuesto);
                oIac.email = txtEmail_Col.Text;
                oIac.tel_Oficina = txtTel_Col.Text;
                oIac.ext_Oficina = txtExt_Col.Text;
                oIac.celular = txtCelular_Col.Text;
                oIac.sexo = Sexop;
                oIac.estado = Convert.ToBoolean(ddlEstado_Col.SelectedValue);
                oIac.fecha_Nacimiento = Convert.ToDateTime(txtFechaNac_Col.Text);
                oIac.fecha_Ingreso_IAC = Convert.ToDateTime(txtFechaIng_Col.Text);


                if (Session["ImageCol"] != null)
                {
                    HttpPostedFile postedImgCol = (HttpPostedFile)Session["ImageCol"];
                    string folderPath = Server.MapPath("~/Archivos/Fotos/" + txtID_Col.Text + "/");
                    if (!Directory.Exists(folderPath))
                    {
                        Directory.CreateDirectory(folderPath);
                    }

                    postedImgCol.SaveAs(folderPath + Path.GetFileName(postedImgCol.FileName));
                    oIac.Ruta_Foto = "~/Archivos/Fotos/" + txtID_Col.Text + "/" + Path.GetFileName(postedImgCol.FileName);
                }
                else
                {
                    oIac.Ruta_Foto = imgFoto_Col.ImageUrl;
                }

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                iacBLL.GuardarIacCol(oIac, oDatos[0].ToString());

                if (ddlEstado_Col.SelectedValue.Equals("true"))
                {
                    SeguridadBLL.activarUsuario(txtID_Col.Text, 1);
                }
                else
                {
                    SeguridadBLL.activarUsuario(txtID_Col.Text, 0);
                }

                guardarArchivoColaborador(oDatos[0].ToString());
                guardarTareaColaborador(oDatos[0].ToString());

                string tab = GetGlobalResourceObject("iac.language", "datoscolaboradores").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsgCol, tab + message, 1);

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsgCol, tab + message, 1);
            }
        }
        private void guardarTareaColaborador(string idUser)
        {
            try
            {
                if (lstTarea_Col.Items.Count != 0)
                {
                    int i = 1;
                    foreach (ListItem item in lstTarea_Col.Items)
                    {
                        iacBLL.GuardarTareaCol(txtID_Col.Text, item.Text, i, idUser);
                        i++;
                    }
                }

            }
            catch (Exception)
            {

            }
        }
        private void guardarArchivoColaborador(string idUser)
        {
            try
            {
                int i = 0;
                if (lstArchivo_Col.Items.Count != 0)
                {
                    iacBLL.DeleteFiles(txtID_Col.Text);

                    foreach (ListItem oFile in lstArchivo_Col.Items)
                    {
                        iacBLL.GuardarArchivoCol(txtID_Col.Text, "~/Archivos/" + txtID_Col.Text + "/" + oFile.Text, i, idUser);
                        i++;

                    }
                }
            }
            catch (Exception)
            {

            }
        }
        /****************************************************************************/
        protected void btnCancelar_Col_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            imgFoto_Col.ImageUrl = "~/Imagenes/logo.png";
            lstArchivo_Col.Items.Clear();
            lstTarea_Col.Items.Clear();
            //oLstTareas.Clear();
            LimpiarCampos(tabColaboradores1.Controls);
        }
        protected void btnEliminar_Col_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            String numero_Identificacion = "";
            try
            {
                numero_Identificacion = txtID_Col.Text;
                EliminarSeguridad(numero_Identificacion);
                LimpiarCampos(tabColaboradores1.Controls);
                string tab = numero_Identificacion;
                string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                showMessage(ltlMsgCol, tab + message, 1);

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsgCol, tab + message, 2);
            }
        }
        private void EliminarSeguridad(String numero_Identificacion)
        {
            ArrayList oDatos = (ArrayList)Session["Usuario"];
            iacBLL.eliminarCol(numero_Identificacion, oDatos[0].ToString());
            SeguridadBLL.eliminarSeguridad(numero_Identificacion, oDatos[0].ToString());
            llenarGrvColabor();
        }
        protected void grvColaboradores_Col_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvColaboradores_Col.Rows[index];
            String idColaborador = "";
            lstArchivo_Col.Items.Clear();
            oLstTareas = new List<Tarea_Colaborador>();
            lstTarea_Col.Items.Clear();
            try
            {
                if (e.CommandName == "Modificar")
                {
                    foreach (DataRow row in iacBLL.getColabor(rowV.Cells[0].Text).Rows)
                    {
                        idColaborador = row[0].ToString();
                        txtID_Col.Text = idColaborador;
                        txtNombre_Col.Text = row[1].ToString();
                        ddlPuesto_Col.SelectedValue = row[2].ToString();
                        txtEmail_Col.Text = row[3].ToString();
                        txtTel_Col.Text = row[4].ToString();
                        txtExt_Col.Text = row[5].ToString();
                        txtCelular_Col.Text = row[6].ToString();
                        ddlSexo_Col.SelectedValue = row[7].ToString();
                        txtFechaNac_Col.Text = Convert.ToDateTime(row[8].ToString()).ToString("yyyy-MM-dd");
                        txtFechaIng_Col.Text = Convert.ToDateTime(row[9].ToString()).ToString("yyyy-MM-dd");
                        imgFoto_Col.ImageUrl = row[10].ToString();
                        ddlEstado_Col.SelectedValue = row[11].ToString();
                    }

                    getTareas(idColaborador);
                    getFiles(idColaborador);

                }
            }
            catch
            {

            }
        }
        private void getFiles(string idColaborador)
        {/*
            try
            {*/

            lstArchivo_Col.Items.Clear();
            try
            {
                if (Directory.Exists(Server.MapPath("~/Archivos/" + idColaborador + "/")))
                {
                    var files = Directory.GetFiles(Server.MapPath("~/Archivos/" + idColaborador + "/"));

                    foreach (var file in files)
                    {
                        lstArchivo_Col.Items.Add(new ListItem(Path.GetFileName(file)));
                    }
                }


            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgCol, tab + message, 2);
            }
            /*
            foreach (DataRow row in iacBLL.obtenerArchivos(idColaborador).Rows)
            {
                string ruta = row[2].ToString();
                lstArchivo_Col.Items.Add(Path.GetFileName(ruta));
            }
            }
            catch (Exception)
            {

                throw;
            }*/
        }
        private void getTareas(string idColaborador)
        {
            try
            {
                foreach (DataRow row in iacBLL.obtenerTareas(idColaborador).Rows)
                {
                    lstTarea_Col.Items.Add(row[2].ToString());
                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsgIAC, tab + message, 2);
            }
        }

        protected void lstArchivo_Col_SelectedIndexChanged(object sender, EventArgs e)
        {
            LimpiarMensajes();
            string s = (string)GetGlobalResourceObject("iac.language", "eleminar");
            btnUpldFile_Col.Text = s;
            btnUpldFile_Col.CssClass = "btn btn-danger btn-sm";
        }
        protected void lstTarea_Col_SelectedIndexChanged(object sender, EventArgs e)
        {
            LimpiarMensajes();
            txtTarea_Col.Text = lstTarea_Col.Items[lstTarea_Col.SelectedIndex].Text;
        }

        private void eliminarArchivo()
        {
            try
            {
                File.Delete(Server.MapPath("~/Archivos/" + txtID_Col.Text + "/" + lstArchivo_Col.SelectedItem.Text));
                lstArchivo_Col.Items.RemoveAt(lstArchivo_Col.SelectedIndex);
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsgIns, tab + message, 2);
            }
        }

        // Language Change 
        protected override void InitializeCulture()
        {
            if (Session["language"] != null)
            {
                Culture = (string)Session["language"];
                UICulture = (string)Session["language"];
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

        private void LimpiarMensajes()
        {
            ltlMsgIns.Text = "";
            ltlMsgIAC.Text = "";
            ltlMsgCol.Text = "";
        }

        protected void showMessage(Literal ltl, string message, int tipo)
        {
            switch (tipo)
            {
                case 1:
                    string divExito1 = "<div id='ltl' class='alert alert-success alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
                    string divExito2 = "</div>";
                    ltl.Text = divExito1 + message + divExito2;
                    ltl.Visible = true;
                    break;

                case 2:
                    string divError1 = "<div id='ltl' class='alert alert-danger  alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
                    string divError2 = "</div>";
                    ltl.Text = divError1 + message + divError2;
                    ltl.Visible = true;
                    break;

                case 3:
                    string divWarn1 = "<div id='ltl' class='alert alert-warning  alert-dismissible'><a href='#' class='close' data-dismiss='alert' aria-label='close'>&times;</a>";
                    string divWarn2 = "</div>";
                    ltl.Text = divWarn1 + message + divWarn2;
                    ltl.Visible = true;
                    break;

                default:
                    break;
            }

            StringBuilder builder = new StringBuilder();

            builder.Append("window.setTimeout(function () {");
            builder.Append("$('.alert').fadeTo(1, 0).slideUp(400, function () {");
            builder.Append("$(this).remove();");
            builder.Append("});");
            builder.Append("}, 5000);");

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", builder.ToString(), true);


            /*
            string tab = txtNombre_Col.Text;
            string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
            showMessage(tab + " " + message);


            string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
            showMessage(tab);*/
        }

        protected void txtID_Col_TextChanged(object sender, EventArgs e)
        {
            string idColaborador = txtID_Col.Text;
            LimpiarMensajes();
            lstArchivo_Col.Items.Clear();
            oLstTareas = new List<Tarea_Colaborador>();
            lstTarea_Col.Items.Clear();
            try
            {
                DataTable dt = iacBLL.getColabor(idColaborador);

                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        idColaborador = row[0].ToString();
                        txtID_Col.Text = idColaborador;
                        txtNombre_Col.Text = row[1].ToString();
                        ddlPuesto_Col.SelectedValue = row[2].ToString();
                        txtEmail_Col.Text = row[3].ToString();
                        txtTel_Col.Text = row[4].ToString();
                        txtExt_Col.Text = row[5].ToString();
                        txtCelular_Col.Text = row[6].ToString();
                        ddlSexo_Col.SelectedValue = row[7].ToString();
                        txtFechaNac_Col.Text = Convert.ToDateTime(row[8].ToString()).ToString("yyyy-MM-dd");
                        txtFechaIng_Col.Text = Convert.ToDateTime(row[9].ToString()).ToString("yyyy-MM-dd");
                        imgFoto_Col.ImageUrl = row[10].ToString();

                        if (row[11].ToString().Equals("0"))
                        {
                            ddlEstado_Col.SelectedValue = "false";
                        }
                        else
                        {
                            ddlEstado_Col.SelectedValue = "true";
                        }
                    }

                    getTareas(idColaborador);
                    getFiles(idColaborador);
                }
                else
                {
                    txtNombre_Col.Text = "";
                    ddlPuesto_Col.SelectedIndex = 0;
                    txtEmail_Col.Text = "";
                    txtTel_Col.Text = "";
                    txtExt_Col.Text = "";
                    txtCelular_Col.Text = "";
                    ddlSexo_Col.SelectedIndex = 0; 
                    txtFechaNac_Col.Text = "";
                    txtFechaIng_Col.Text = "";
                    imgFoto_Col.ImageUrl = "";
                    ddlEstado_Col.SelectedIndex = 0;
                }
            }
            catch (Exception)
            {

            }
        }

        protected void btnDescargarArchivo_Col_Click(object sender, EventArgs e)
        {
            if (lstArchivo_Col.SelectedIndex != -1)
            {
                btnDescargarArchivo_Col.Visible = true;
                DescargarArchivo(Server.MapPath("~/Archivos/" + txtID_Col.Text + "/" + lstArchivo_Col.SelectedItem.Text), lstArchivo_Col.SelectedItem.Text);
            }
            else
            {
                string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                string message1 = "";
                showMessage(ltlMsgCol, tab1 + message1, 2);
            }
        }

        protected void DescargarArchivo(string strRuta, string strFile)
        {
            FileInfo ObjArchivo = new System.IO.FileInfo(strRuta);
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + strFile);
            Response.AddHeader("Content-Length", ObjArchivo.Length.ToString());
            Response.ContentType = "application/pdf";
            Response.WriteFile(ObjArchivo.FullName);
            Response.End();
        }

    }
}