using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections;
using System.Drawing;
using Entidad;
using BLL;
using System.Data;
using System.Text;
using MySql.Data.MySqlClient;
using System.IO;
using System.Security.Cryptography;



namespace slnCAI
{
    public partial class Seguridad : System.Web.UI.Page
    {
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
            ltlMessage.Visible = false;
        }

        private void crearTabs(string idRol)
        {
            StringBuilder oTabs = new StringBuilder();

            try
            {
                DataTable dt = SeguridadBLL.getMenu(Convert.ToInt32(idRol), "Seguridad");
                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow oRow in dt.Rows)
                    {
                        oTabs.Append("<li><a data-toggle='tab' href='");
                        oTabs.Append(oRow["url"].ToString());

                        oTabs.Append("'>");
                        oTabs.Append(GetGlobalResourceObject("seguridad.language", oRow["permiso"].ToString()).ToString());
                        oTabs.Append("</a></li>");

                        String idTab = oRow["url"].ToString().Substring(1) + 1;

                        switch (idTab)
                        {
                            case "tabUsuarios1":
                                tabUsuarios1.Visible = true;
                                //
                                fillGridViewUsers();
                                fillDdlRol(ddlRol_User);
                                break;

                            case "tabRoles1":
                                tabRoles1.Visible = true;
                                //
                                fillGridViewRol();
                                break;

                            case "tabPermisos1":
                                tabPermisos1.Visible = true;
                                //
                                fillDdlRol(ddlRol_Perm);
                                fillChkBox();
                                fillddlColaborador();
                                if (ddlRol_Perm.SelectedIndex != -1)
                                {
                                    fillChkBox(Convert.ToInt32(ddlRol_Perm.SelectedItem.Value));
                                }
                                break;

                            case "tabBitacora1":
                                tabBitacora1.Visible = true;
                                llenarBitacora();
                                break;

                            case "tabBackup1":
                                tabBackup1.Visible = true;
                                string folderPath = Server.MapPath("~/Backup/");
                                if (!Directory.Exists(folderPath))
                                {
                                    Directory.CreateDirectory(folderPath);
                                }
                                llenarListBackup();
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
                    SeguridadPage.Visible = false;
                }

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMessage, tab + message, 2);
            }
        }

        private void llenarBitacora()
        {
            StringBuilder sbTabla = new StringBuilder();

            try
            {
                DataTable dt = SeguridadBLL.getBitacora();

                if (dt.Rows.Count != 0)
                {
                    sbTabla.Append("<table style='width:100%' id='tblBitacora' class='table table-bordered table-hover'>");
                    sbTabla.Append("<thead>");
                    sbTabla.Append("<tr style='text-align:center; background-color:#002442 !important; color: #fff !important;'>");
                    foreach (DataColumn col in dt.Columns)
                    {
                        sbTabla.Append("<th>");
                        sbTabla.Append(GetGlobalResourceObject("seguridad.language", col.ToString()).ToString());
                        sbTabla.Append("</th>");
                    }
                    sbTabla.Append("</tr>");
                    sbTabla.Append("</thead>");
                    sbTabla.Append("<tbody>");

                    foreach (DataRow row in dt.Rows)
                    {
                        sbTabla.Append("<tr>");
                        foreach (DataColumn col in dt.Columns)
                        {

                            switch (col.ColumnName)
                            {
                                case "numero_Identificacion":

                                    if (!row[col.ToString()].ToString().Equals("System"))
                                    {
                                        sbTabla.Append("<td>");
                                        sbTabla.Append(SeguridadBLL.getUsers(row[col.ToString()].ToString()).Rows[0]["usuario"]);
                                        sbTabla.Append("</td>");
                                    }
                                    else
                                    {
                                        sbTabla.Append("<td>");
                                        sbTabla.Append(row[col.ToString()].ToString());
                                        sbTabla.Append("</td>");
                                    }
                                    break;

                                case "fecha_Accion":
                                    sbTabla.Append("<td>");
                                    sbTabla.Append(Convert.ToDateTime(row[col.ToString()].ToString()).ToShortDateString());
                                    sbTabla.Append("</td>");
                                    break;

                                case "hora_Accion":
                                    sbTabla.Append("<td>");
                                    sbTabla.Append(Convert.ToDateTime(row[col.ToString()].ToString()).ToShortTimeString());
                                    sbTabla.Append("</td>");
                                    break;

                                case "modulo_Accesado":
                                    sbTabla.Append("<td>");
                                    sbTabla.Append(row[col.ToString()].ToString());
                                    sbTabla.Append("</td>");
                                    break;

                                case "movimiento_Ejecutado":
                                    sbTabla.Append("<td>");
                                    sbTabla.Append(row[col.ToString()].ToString());
                                    sbTabla.Append("</td>");
                                    break;

                                default:
                                    sbTabla.Append("<td>");
                                    sbTabla.Append(row[col.ToString()].ToString());
                                    sbTabla.Append("</td>");
                                    break;
                            }



                        }
                        sbTabla.Append("</tr>");
                    }


                    sbTabla.Append("</tbody>");
                    sbTabla.Append("</table>");
                    ltlBitacora.Text = sbTabla.ToString();
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void refrescarCampos()
        {
            try
            {
                fillGridViewUsers();
                fillDdlRol(ddlRol_User);

                fillGridViewRol();

                fillDdlRol(ddlRol_Perm);
                fillChkBox();
                fillddlColaborador();
                if (ddlRol_Perm.SelectedIndex != -1)
                {
                    fillChkBox(Convert.ToInt32(ddlRol_Perm.SelectedItem.Value));
                }

                llenarListBackup();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void llenarListBackup()
        {
            lstBackups.Items.Clear();
            try
            {
                var files = Directory.GetFiles(Server.MapPath("~/Backup/"));

                foreach (var file in files)
                {
                    lstBackups.Items.Add(new ListItem(Path.GetFileName(file)));
                }

            }
            catch (Exception)
            {

                throw;
            }
        }

        /*************************************  Tab Usuarios  ************************************************/

        private void fillddlColaborador()
        {
            try
            {
                ddlColaborador.DataSource = iacBLL.getColabor();
                ddlColaborador.DataTextField = "nombre_Completo";
                ddlColaborador.DataValueField = "numero_Identificacion";
                ddlColaborador.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Usuarios, tab + message, 2);
            }
        }

        private void fillGridViewUsers()
        {
            try
            {
                grvUser_User.DataSource = SeguridadBLL.getUsers();
                grvUser_User.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Usuarios, tab + message, 2);
            }
        }

        protected void btnGuardar_User_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtUser_User);
            olstCampos.Add(txtPass_User);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarSeguridad();
                LimpiarCampos(tabUsuarios1.Controls);

                refrescarCampos();
                string tab = GetGlobalResourceObject("seguridad.language", "usuarios").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Usuarios, tab + message, 1);
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Usuarios, tab + message, 2);
            }
        }

        protected void GuardarSeguridad()
        {
            try
            {
                SeguridadUsuario oSeguridad = new SeguridadUsuario();
                try
                {
                    oSeguridad.numero_Identificacion = ddlColaborador.SelectedValue;
                }
                catch (Exception)
                {
                    oSeguridad.numero_Identificacion = "";
                }
                String sItem = Convert.ToString(ddlRol_User.SelectedItem.Value);
                oSeguridad.nombre_Completo = ddlColaborador.SelectedItem.Text;
                oSeguridad.usuario = txtUser_User.Text;
                oSeguridad.contrasenna = txtPass_User.Text;
                oSeguridad.idRol_Usuario = Convert.ToInt32(sItem);

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                SeguridadBLL.GuardarSeguridad(oSeguridad, oDatos[0].ToString());
                fillGridViewUsers();


            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Usuarios, tab + message, 2);
            }
        }

        protected void btnCancelar_User_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            //txtId_User.Text = "";
            //txtNombre_User.Text = "";
            txtUser_User.Text = "";
            txtPass_User.Text = "";
        }

        protected void btnEliminar_User_Click(object sender, EventArgs e)
        {

        }

        private void EliminarSeguridad(String numero_Identificacion)
        {
            try
            {
                ArrayList oDatos = (ArrayList)Session["Usuario"];
                SeguridadBLL.eliminarSeguridad(numero_Identificacion, oDatos[0].ToString());
                fillGridViewUsers();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Usuarios, tab + message, 2);
            }
        }

        protected void grvUsuario_User_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvUser_User.Rows[index];

            string numeroIdentificacion = grvUser_User.DataKeys[index][0].ToString();
            string idRol = grvUser_User.DataKeys[index][1].ToString();

            try
            {
                switch (e.CommandName)
                {
                    case "Modificar":
                        ddlColaborador.SelectedValue = numeroIdentificacion;
                        txtUser_User.Text = rowV.Cells[1].Text;
                        ddlRol_User.SelectedValue = idRol;
                        break;

                    case "Eliminar":
                        EliminarSeguridad(numeroIdentificacion);
                        refrescarCampos();
                        string tab = GetGlobalResourceObject("seguridad.language", "usuarios").ToString();
                        string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                        showMessage(ltlMsg_Usuarios, tab + message, 1);
                        break;
                    default:
                        break;
                }
            }
            catch
            {

            }
        }


        /****************************************  Tab Rol  **************************************************/

        private void fillGridViewRol()
        {
            try
            {
                grvRoles_Rol.DataSource = SeguridadBLL.getRol();
                grvRoles_Rol.DataBind();

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Roles, tab + message, 2);
            }
        }

        protected void btnGuardar_Rol_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtRol_Rol);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarSeguridadRol();
                refrescarCampos();
                string tab = GetGlobalResourceObject("seguridad.language", "rol").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Roles, tab + message, 1);
                txtId_Rol.Text = "";
                txtRol_Rol.Text = "";
                txtDescri_Rol.Text = "";
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Roles, tab + message, 2);
            }
        }

        protected void btnCancelar_Rol_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            txtId_Rol.Text = "";
            txtRol_Rol.Text = "";
            txtDescri_Rol.Text = "";
        }

        protected void btnEliminar_Rol_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            int idRol = 0;
            try
            {
                if (!string.IsNullOrEmpty(txtId_Rol.Text))
                {
                    idRol = Convert.ToInt32(txtId_Rol.Text);
                    EliminarSeguridadRol(idRol);
                    refrescarCampos();
                    string tab = GetGlobalResourceObject("seguridad.language", "rol").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Roles, tab + message, 1);
                    txtId_Rol.Text = "";
                    txtRol_Rol.Text = "";
                    txtDescri_Rol.Text = "";
                }
                else
                {
                    string tab = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message = "";
                    showMessage(ltlMsg_Roles, tab + message, 2);
                }


            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Roles, tab + message, 2);
            }
        }

        protected void GuardarSeguridadRol()
        {
            try
            {
                SeguridadRol oSeguridad = new SeguridadRol();
                try
                {
                    oSeguridad.idRol = Convert.ToInt32(txtId_Rol.Text);
                }
                catch (Exception)
                {
                    oSeguridad.idRol = 0;
                }
                oSeguridad.rol = txtRol_Rol.Text;
                oSeguridad.descripcion = txtDescri_Rol.Text;

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                SeguridadBLL.GuardarSeguridadRol(oSeguridad, oDatos[0].ToString());
                fillGridViewRol();



            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Usuarios, tab + message, 2);
            }
        }

        private void EliminarSeguridadRol(int idRol)
        {
            try
            {
                ArrayList oDatos = (ArrayList)Session["Usuario"];
                SeguridadBLL.eliminarSeguridadRol(idRol, oDatos[0].ToString());
                ltlMessage.Text = "<div class='alert alert-success'><strong>Éxito!</strong> Puesto Eliminado correctamente.</div>";
                ltlMessage.Visible = true;
                fillGridViewRol();
            }
            catch (Exception)
            {
                ltlMessage.Text = "<div sclass='alert alert-danger'><strong>Error!</strong> al Eliminar el Puesto.</div>";
                ltlMessage.Visible = true;
            }
        }

        protected void grvUsuario_Rol_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvRoles_Rol.Rows[index];
            string idRol = grvRoles_Rol.DataKeys[index][0].ToString();

            try
            {
                if (e.CommandName == "Modificarp")
                {
                    txtId_Rol.Text = idRol;
                    txtRol_Rol.Text = rowV.Cells[0].Text;
                    if (rowV.Cells[1].Text.Equals("&nbsp:"))
                    {
                        txtDescri_Rol.Text = "";
                    }
                    else
                    {
                        txtDescri_Rol.Text = rowV.Cells[2].Text;
                    }
                }
            }
            catch
            {

            }
        }

        /*************************************  Tab Permisos  ************************************************/

        private void fillChkBox()
        {
            try
            {
                chkIAC_Perm.Items.Clear();
                chkManteni_Perm.Items.Clear();
                chkProceso_Perm.Items.Clear();
                chkSeguridad_Perm.Items.Clear();
                chkMenuPrincipal_Perm.Items.Clear();
                chkReporte_Perm.Items.Clear();

                ListItem item = new ListItem();
                foreach (DataRow row in SeguridadBLL.getPermition().Rows)
                {
                    switch (row[2].ToString())
                    {
                        case "IAC":
                            item = new ListItem(GetGlobalResourceObject("seguridad.language", row[1].ToString()).ToString(), row[0].ToString());
                            chkIAC_Perm.Items.Add(item);
                            break;

                        case "Mantenimiento":
                            item = new ListItem(GetGlobalResourceObject("seguridad.language", row[1].ToString()).ToString(), row[0].ToString());
                            chkManteni_Perm.Items.Add(item);
                            break;

                        case "Procesos":
                            item = new ListItem(GetGlobalResourceObject("seguridad.language", row[1].ToString()).ToString(), row[0].ToString());
                            chkProceso_Perm.Items.Add(item);
                            break;

                        case "Seguridad":
                            item = new ListItem(GetGlobalResourceObject("seguridad.language", row[1].ToString()).ToString(), row[0].ToString());
                            chkSeguridad_Perm.Items.Add(item);
                            break;
                        case "Principal":
                            item = new ListItem(GetGlobalResourceObject("site.language", row[1].ToString()).ToString(), row[0].ToString());
                            chkMenuPrincipal_Perm.Items.Add(item);
                            break;
                        case "Reporte":
                            item = new ListItem(GetGlobalResourceObject("seguridad.language", row[1].ToString()).ToString(), row[0].ToString());
                            chkReporte_Perm.Items.Add(item);
                            break;
                    }


                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Permisos, tab + message, 2);
            }
        }

        private void fillChkBox(int idRol)
        {
            try
            {
                foreach (DataRow row in SeguridadBLL.getPermition(idRol).Rows)
                {
                    switch (row["pagina"].ToString())
                    {
                        case "IAC":
                            chkIAC_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected = Convert.ToBoolean(Convert.ToInt32(row["estado"].ToString()));

                            if (chkIAC_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected == true)
                            {
                                chkIAC_Perm.Items.FindByValue(row["idPermiso"].ToString()).Attributes.Add("Style", "color: green;");
                            }
                            break;

                        case "Mantenimiento":

                            chkManteni_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected = Convert.ToBoolean(Convert.ToInt32(row["estado"].ToString()));

                            if (chkManteni_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected == true)
                            {
                                chkManteni_Perm.Items.FindByValue(row["idPermiso"].ToString()).Attributes.Add("Style", "color: green;");
                            }
                            break;

                        case "Procesos":
                            chkProceso_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected = Convert.ToBoolean(Convert.ToInt32(row["estado"].ToString()));

                            if (chkProceso_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected == true)
                            {
                                chkProceso_Perm.Items.FindByValue(row["idPermiso"].ToString()).Attributes.Add("Style", "color: green;");
                            }
                            break;

                        case "Seguridad":
                            chkSeguridad_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected = Convert.ToBoolean(Convert.ToInt32(row["estado"].ToString()));

                            if (chkSeguridad_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected == true)
                            {
                                chkSeguridad_Perm.Items.FindByValue(row["idPermiso"].ToString()).Attributes.Add("Style", "color: green;");
                            }
                            break;

                        case "Principal":
                            chkMenuPrincipal_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected = Convert.ToBoolean(Convert.ToInt32(row["estado"].ToString()));

                            if (chkMenuPrincipal_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected == true)
                            {
                                chkMenuPrincipal_Perm.Items.FindByValue(row["idPermiso"].ToString()).Attributes.Add("Style", "color: green;");
                            }

                            break;

                        case "Reporte":
                            chkReporte_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected = Convert.ToBoolean(Convert.ToInt32(row["estado"].ToString()));

                            if (chkReporte_Perm.Items.FindByValue(row["idPermiso"].ToString()).Selected == true)
                            {
                                chkReporte_Perm.Items.FindByValue(row["idPermiso"].ToString()).Attributes.Add("Style", "color: green;");
                            }
                            break;
                    }
                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Permisos, tab + message, 2);
            }
        }

        protected void chkIAC_Perm_SelectedIndexChanged(object sender, EventArgs e)
        {
            RevisarChkIAC();
        }

        protected void chkProceso_Perm_SelectedIndexChanged(object sender, EventArgs e)
        {
            RevisarChkProceso();
        }

        protected void chkSeguridad_Perm_SelectedIndexChanged(object sender, EventArgs e)
        {
            RevisarChkSeguridad();
        }

        private void RevisarChkIAC()
        {
            int count = 0;
            foreach (ListItem item in chkIAC_Perm.Items)
            {
                if (item.Selected == true)
                {
                    count++;
                }
            }

            if (count != 0)
            {
                chkMenuPrincipal_Perm.Items.FindByValue("2").Selected = true;
            }
            else
            {
                chkMenuPrincipal_Perm.Items.FindByValue("2").Selected = false;
            }
        }

        private void RevisarChkMantenimiento()
        {
            int count = 0;
            foreach (ListItem item in chkManteni_Perm.Items)
            {
                if (item.Selected == true)
                {
                    count++;
                }
            }

            if (count != 0)
            {
                chkMenuPrincipal_Perm.Items.FindByValue("3").Selected = true;
            }
            else
            {
                chkMenuPrincipal_Perm.Items.FindByValue("3").Selected = false;
            }
        }

        private void RevisarChkProceso()
        {
            int count = 0;
            foreach (ListItem item in chkProceso_Perm.Items)
            {
                if (item.Selected == true)
                {
                    count++;
                }
            }

            if (count != 0)
            {
                chkMenuPrincipal_Perm.Items.FindByValue("4").Selected = true;
            }
            else
            {
                chkMenuPrincipal_Perm.Items.FindByValue("4").Selected = false;
            }
        }

        private void RevisarChkSeguridad()
        {
            int count = 0;
            foreach (ListItem item in chkSeguridad_Perm.Items)
            {
                if (item.Selected == true)
                {
                    count++;
                }
            }

            if (count != 0)
            {
                chkMenuPrincipal_Perm.Items.FindByValue("5").Selected = true;
            }
            else
            {
                chkMenuPrincipal_Perm.Items.FindByValue("5").Selected = false;
            }
        }

        private void RevisarChkReporte()
        {
            int count = 0;
            foreach (ListItem item in chkReporte_Perm.Items)
            {
                if (item.Selected == true)
                {
                    count++;
                }
            }

            if (count != 0)
            {
                chkMenuPrincipal_Perm.Items.FindByValue("6").Selected = true;
            }
            else
            {
                chkMenuPrincipal_Perm.Items.FindByValue("6").Selected = false;
            }
        }

        protected void chkManteni_Perm_SelectedIndexChanged(object sender, EventArgs e)
        {
            RevisarChkMantenimiento();
        }

        protected void btnGuardar_Perm_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                int idRol = 0;
                int idPermiso = 0;
                bool estado = false;

                ArrayList oChk = new ArrayList();
                oChk.Add(chkIAC_Perm);
                oChk.Add(chkManteni_Perm);
                oChk.Add(chkProceso_Perm);
                oChk.Add(chkSeguridad_Perm);
                oChk.Add(chkMenuPrincipal_Perm);
                oChk.Add(chkReporte_Perm);

                idRol = Convert.ToInt32(ddlRol_Perm.SelectedItem.Value);

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                foreach (CheckBoxList chklist in oChk)
                {
                    for (int i = 0; i < chklist.Items.Count; i++)
                    {
                        idPermiso = Convert.ToInt32(chklist.Items[i].Value);
                        estado = chklist.Items[i].Selected;
                        SeguridadBLL.guardarPermiso(idRol, idPermiso, estado, oDatos[0].ToString());
                    }
                }

                Response.Redirect(Request.RawUrl);


                string tab = GetGlobalResourceObject("seguridad.language", "permisos").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Permisos, tab + message, 1);
            }
            catch (Exception ex)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "" + ex.ToString();
                showMessage(ltlMsg_Permisos, tab + message, 2);
            }
        }

        protected void ddlRol_Perm_SelectedIndexChanged(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (ddlRol_Perm.SelectedIndex != -1)
            {
                fillChkBox(Convert.ToInt32(ddlRol_Perm.SelectedItem.Value));
            }

        }

        /***********************************  Backup / Restore  **********************************************/

        protected void btnCrearBackup_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            string ruta = Server.MapPath("~/Backup/");

            try
            {
                string nombre = SeguridadBLL.crearBackup(ruta);
                llenarListBackup();

                string tab = GetGlobalResourceObject("seguridad.language", "backup").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Permisos, tab + message, 1);
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Permisos, tab + message, 2);
            }

        }

        protected void btnResturar_Rest_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (lstBackups.SelectedIndex != -1)
            {
                try
                {
                    SeguridadBLL.restaurarBackup(Server.MapPath("~/Backup/" + lstBackups.SelectedItem.Text));
                    Response.Redirect(Request.RawUrl);
                    string tab = "";
                    string message = GetGlobalResourceObject("Mensajes.language", "resturar").ToString();
                    showMessage(ltlMsg_Backup, tab + message, 1);
                }
                catch (Exception)
                {
                    string tab = GetGlobalResourceObject("Mensajes.language", "restaurarError").ToString();
                    string message = "";
                    showMessage(ltlMsg_Backup, tab + message, 2);
                }
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                string message = "";
                showMessage(ltlMsg_Backup, tab + message, 2);
            }
        }

        protected void btnEliminar_Rest_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (lstBackups.SelectedIndex != -1)
            {
                try
                {
                    File.Delete(Server.MapPath("~/Backup/" + lstBackups.SelectedItem.Text));
                    lstBackups.Items.RemoveAt(lstBackups.SelectedIndex);
                    llenarListBackup();

                    string tab = GetGlobalResourceObject("seguridad.language", "backup").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Backup, tab + message, 1);

                }
                catch (Exception)
                {
                    string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                    string message = "";
                    showMessage(ltlMsg_Backup, tab + message, 2);
                }

            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                string message = "";
                showMessage(ltlMsg_Backup, tab + message, 2);
            }
        }

        protected void DescargarArchivo(string strRuta, string strFile)
        {
            FileInfo ObjArchivo = new System.IO.FileInfo(strRuta);
            Response.Clear();
            Response.AddHeader("Content-Disposition", "attachment; filename=" + strFile);
            Response.AddHeader("Content-Length", ObjArchivo.Length.ToString());
            Response.ContentType = "application/sql";
            Response.WriteFile(ObjArchivo.FullName);
            Response.Flush();
            File.Delete(strRuta);
            Response.End();


        }

        protected void btnDescargarRespaldo_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (lstBackups.SelectedIndex != -1)
            {
                string folder = "~/Backup/" + lstBackups.SelectedItem.Text;
                string output = "~/Backup/" + "enc" + lstBackups.SelectedItem.Text;
                Encrypt(Server.MapPath(folder), Server.MapPath(output));
                DescargarArchivo(Server.MapPath(output), lstBackups.SelectedItem.Text.Substring(0, lstBackups.SelectedItem.Text.IndexOf('.')) + ".iac");
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                string message = "";
                showMessage(ltlMsg_Backup, tab + message, 2);
            }
        }

        protected void btnUploadBackup_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (flpBackupUpload.HasFile)
            {
                if (Path.GetExtension(flpBackupUpload.FileName).Equals(".iac"))
                {
                    if (lstBackups.Items.FindByText(flpBackupUpload.FileName) == null)
                    {
                        flpBackupUpload.SaveAs(Server.MapPath("~/Backup/enc" + flpBackupUpload.FileName));

                        Decrypt(Server.MapPath("~/Backup/enc" + flpBackupUpload.FileName), Server.MapPath("~/Backup/" + flpBackupUpload.FileName));
                        File.Delete(Server.MapPath("~/Backup/enc" + flpBackupUpload.FileName));
                    }
                    else
                    {
                        flpBackupUpload.SaveAs(Server.MapPath("~/Backup/enc" + flpBackupUpload.FileName));

                        Decrypt(Server.MapPath("~/Backup/enc" + flpBackupUpload.FileName), Server.MapPath("~/Backup/copy" + flpBackupUpload.FileName));
                        File.Delete(Server.MapPath("~/Backup/enc" + flpBackupUpload.FileName));
                    }
                    llenarListBackup();
                }
                else
                {
                    string tab = GetGlobalResourceObject("Mensajes.language", "extError").ToString();
                    string message = "";
                    showMessage(ltlMsg_Backup, tab + message, 2);
                }

            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "uploadFile").ToString();
                string message = "";
                showMessage(ltlMsg_Backup, tab + message, 2);
            }
        }

        private void Encrypt(string inputFilePath, string outputfilePath)
        {
            string EncryptionKey = "#YpDM8vwi#oQ6";
            using (Aes encryptor = Aes.Create())
            {
                Rfc2898DeriveBytes pdb = new Rfc2898DeriveBytes(EncryptionKey, new byte[] { 0x49, 0x76, 0x61, 0x6e, 0x20, 0x4d, 0x65, 0x64, 0x76, 0x65, 0x64, 0x65, 0x76 });
                encryptor.Key = pdb.GetBytes(32);
                encryptor.IV = pdb.GetBytes(16);
                using (FileStream fsOutput = new FileStream(outputfilePath, FileMode.Create))
                {
                    using (CryptoStream cs = new CryptoStream(fsOutput, encryptor.CreateEncryptor(), CryptoStreamMode.Write))
                    {
                        using (FileStream fsInput = new FileStream(inputFilePath, FileMode.Open))
                        {
                            int data;
                            while ((data = fsInput.ReadByte()) != -1)
                            {
                                cs.WriteByte((byte)data);
                            }
                        }
                    }
                }
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
        protected void crearBackup()
        {
            try
            {

            }
            catch (Exception)
            {

                throw;
            }
        }

        /********************************  Metodos compartidos  **********************************************/

        private void fillDdlRol(DropDownList ddlRol)
        {
            try
            {
                ddlRol.DataSource = SeguridadBLL.getRol();
                ddlRol.DataValueField = "idRol";
                ddlRol.DataTextField = "rol";
                ddlRol.DataBind();

            }
            catch (Exception)
            {

                throw;
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

        private void MessageBoxShow(string message, string class1)
        {
            //this.AlertBoxMessage.InnerText = message;
            //this.AlertBox.Visible = true;
            //.Attributes.Add("class","alertBox " + class1);
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

        protected void chkReporte_Perm_SelectedIndexChanged(object sender, EventArgs e)
        {
            RevisarChkReporte();
        }

        /******************************************  Fin  ****************************************************/
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



            StringBuilder builder = new StringBuilder();

            builder.Append("window.setTimeout(function () {");
            builder.Append("$('.alert').fadeTo(1, 0).slideUp(500, function () {");
            builder.Append("$(this).remove();");
            builder.Append("});");
            builder.Append("}, 5000);");

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", builder.ToString(), true);

        }

        private void LimpiarMensajes()
        {
            ltlMsg_Usuarios.Text = "";
            ltlMsg_Roles.Text = "";
            ltlMsg_Permisos.Text = "";
            ltlMsg_Bitacora.Text = "";
            ltlMsg_Backup.Text = "";
        }
    }
}