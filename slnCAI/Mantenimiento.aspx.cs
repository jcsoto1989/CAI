using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Entidad;
using BLL;
using System.Collections;
using System.Drawing;
using System.Data;
using System.Text;

namespace slnCAI
{
    public partial class Mantenimiento : System.Web.UI.Page
    {
        private static List<TipoEquipoEspacio> oLstTipoEquipoEspacio;
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
            ltlMessage.Text = "";
            ltlMessage.Visible = false;
        }

        private void crearTabs(string idRol)
        {
            StringBuilder oTabs = new StringBuilder();

            try
            {
                DataTable dt = SeguridadBLL.getMenu(Convert.ToInt32(idRol), "Mantenimiento");
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
                            case "tabPuesto1":
                                tabPuesto1.Visible = true;
                                //
                                FillGridViewPuestos();
                                break;

                            case "tabTipoEquipo1":
                                tabTipoEquipo1.Visible = true;
                                //
                                FillGridViewTipoEquipo();
                                break;

                            case "tabEquipo1":
                                tabEquipo1.Visible = true;
                                //
                                FillGridViewEquipo();
                                FillDownEncargado(ddlEncargado_Eqp);
                                FillDownTipoEquipo(ddlTipoEquipo_Eqp);
                                FillDownMarca(ddlMarca_Eqp);
                                FillDownEspacio(ddlEspacio_Eqp);
                                FillDownCondicion(ddlCondicion_Eqp);
                                FillDdlEstado();
                                break;

                            case "tabEspacio1":
                                tabEspacio1.Visible = true;
                                //
                                oLstTipoEquipoEspacio = new List<TipoEquipoEspacio>();
                                FillDownEncargado(ddlEncargado_Esp);
                                FillDownTipoEquipo(ddlTipoEqp_Esp);
                                FillGridViewEspacio();
                                oLstTipoEquipoEspacio.Clear();
                                break;

                            case "tabInstituciones1":
                                tabInstituciones1.Visible = true;
                                //
                                FillGridViewInstitucion();
                                break;

                            case "tabMarcas1":
                                tabMarcas1.Visible = true;
                                //
                                FillGridViewMarca();
                                break;

                            case "tabCondicion1":
                                tabCondicion1.Visible = true;
                                //
                                FillGridViewCondicion();
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
                    MantenimientoPage.Visible = false;
                }

            }
            catch (Exception )
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMessage, tab + message, 2);

            }
        }

        private void refrescarCampos()
        {
            try
            {
                 FillGridViewPuestos();
                 FillGridViewTipoEquipo();
                 FillGridViewEquipo();
                 FillDownEncargado(ddlEncargado_Eqp);
                 FillDownTipoEquipo(ddlTipoEquipo_Eqp);
                 FillDownMarca(ddlMarca_Eqp);
                 FillDownEspacio(ddlEspacio_Eqp);
                 FillDownCondicion(ddlCondicion_Eqp);
                 FillDdlEstado();

                 oLstTipoEquipoEspacio = new List<TipoEquipoEspacio>();
                 FillDownEncargado(ddlEncargado_Esp);
                 FillDownTipoEquipo(ddlTipoEqp_Esp);
                 FillGridViewEspacio();
                 oLstTipoEquipoEspacio.Clear();

                 FillGridViewInstitucion();

                 FillGridViewMarca();

                 FillGridViewCondicion();
            }
            catch (Exception)
            {
                
                throw;
            }
        }
        /////////////////////////////////////////////////////////////////////
        ///                          Puesto Part Start                    ///
        /////////////////////////////////////////////////////////////////////
        //Metodos Pestaña Puesto - Methods Puestos Tab - Start
        //Fills the gridview
        private void FillGridViewPuestos()
        {
            try
            {
                grvPuesto_Pst.DataSource = MantenimientoBLL.obtenerPuestos();
                grvPuesto_Pst.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Puesto, tab + message, 2);
            }
        }
        //Button Action to save or update
        protected void btnGuardar_Pst_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtPuesto_Pst);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarPuesto();

                ArrayList oControles = new ArrayList();
                oControles.Add(txtId_Pst);
                oControles.Add(txtPuesto_Pst);
                oControles.Add(txtObserv_Pst);

                LimpiarCampos(oControles);
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Puesto, tab + message, 2);
            }
        }
        //Save and update method
        protected void GuardarPuesto()
        {
            try
            {
                Puesto oPuesto = new Puesto();
                try
                {
                    oPuesto.idPuesto = Convert.ToInt32(txtId_Pst.Text);
                }
                catch (Exception)
                {
                    oPuesto.idPuesto = 0;
                }
                oPuesto.puesto = txtPuesto_Pst.Text;
                oPuesto.observaciones = txtObserv_Pst.Text;

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                MantenimientoBLL.GuardarPuesto(oPuesto,oDatos[0].ToString());
                FillGridViewPuestos();

                string tab = GetGlobalResourceObject("mantenimiento.language", "puesto").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Puesto, tab + message, 1);

                refrescarCampos();

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Puesto, tab + message, 2);
            }
        }

        //Gridview button update and fills the textbox 
        protected void grvPuesto_Pst_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvPuesto_Pst.Rows[index];
            string idPuesto = grvPuesto_Pst.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar")
                {
                    txtId_Pst.Text = idPuesto;
                    txtPuesto_Pst.Text = rowV.Cells[1].Text;
                    if (rowV.Cells[2].Text.Equals("&nbsp;"))
                    {
                        txtObserv_Pst.Text = "";
                    }
                    else
                    {
                        txtObserv_Pst.Text = rowV.Cells[2].Text;
                    }

                }
            }
            catch
            {

            }
        }

        //Cancel button, Clean the textbox
        protected void btnCancelar_Pst_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oControles = new ArrayList();
            oControles.Add(txtId_Pst);
            oControles.Add(txtPuesto_Pst);
            oControles.Add(txtObserv_Pst);

            LimpiarCampos(oControles);
        }

        //Delete Button, logical delete put state in 0 on the database
        protected void btnEliminar_Pst_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            int idPuesto = 0;
            try
            {
                if (!string.IsNullOrEmpty(txtId_Pst.Text))
                {
                    ArrayList oDatos = (ArrayList)Session["Usuario"];
                    idPuesto = Convert.ToInt32(txtId_Pst.Text);
                    EliminarPuesto(idPuesto, oDatos[0].ToString());

                    string tab = GetGlobalResourceObject("mantenimiento.language", "puesto").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Puesto, tab + message, 1);
                }
                else
                {
                    string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message1 = "";
                    showMessage(ltlMsg_Puesto, tab1 + message1, 2);
                }

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Puesto, tab + message, 2);
            }
        }

        private void EliminarPuesto(int idPuesto, string idUser)
        {
            MantenimientoBLL.eliminarPuesto(idPuesto,idUser);
            FillGridViewPuestos();
        }

        /////////////////////////////////////////////////////////////////////
        ///                          Puesto Part End                      ///
        /////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////
        ///                   Tipo Equipo Part Start                      ///
        /////////////////////////////////////////////////////////////////////

        private void FillGridViewTipoEquipo()
        {
            try
            {
                grvTipoEquipo_TpE.DataSource = MantenimientoBLL.getTipoEquipo();
                grvTipoEquipo_TpE.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_TpEquipo, tab + message, 2);
            }
        }

        //Button Action to save or update
        protected void btnGuardar_TpE_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtTpEquipo_TpE);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarTipoEquipo();
                ArrayList oControles = new ArrayList();
                oControles.Add(txtIdTpE_TpE);
                oControles.Add(txtTpEquipo_TpE);
                oControles.Add(txtObserv_TpE);

                LimpiarCampos(oControles);
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_TpEquipo, tab + message, 2);
            }
        }
        //Save and update method
        protected void GuardarTipoEquipo()
        {
            try
            {
                TipoEquipo oTipoEquipo = new TipoEquipo();
                try
                {
                    oTipoEquipo.idTipoEquipo = Convert.ToInt32(txtIdTpE_TpE.Text);
                }
                catch (Exception)
                {
                    oTipoEquipo.idTipoEquipo = 0;
                }
                oTipoEquipo.TipoEquipop = txtTpEquipo_TpE.Text;
                oTipoEquipo.observaciones = txtObserv_TpE.Text;

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                MantenimientoBLL.GuardarTipoEquipo(oTipoEquipo,oDatos[0].ToString());
                FillGridViewTipoEquipo();
                FillDownTipoEquipo(ddlTipoEquipo_Eqp);
                FillDownTipoEquipo(ddlTipoEqp_Esp);

                string tab = GetGlobalResourceObject("mantenimiento.language", "tipoequipo").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_TpEquipo, tab + message, 1);
                refrescarCampos();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_TpEquipo, tab + message, 2);
            }
        }
        //Gridview button update and fills the textbox 
        protected void grvTipoEquipo_TpE_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvTipoEquipo_TpE.Rows[index];
            string Id = grvTipoEquipo_TpE.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar2")
                {
                    txtIdTpE_TpE.Text = Id;
                    txtTpEquipo_TpE.Text = rowV.Cells[1].Text;
                    if (rowV.Cells[2].Text.Equals("&nbsp;"))
                    {
                        txtObserv_TpE.Text = "";
                    }
                    else
                    {
                        txtObserv_TpE.Text = rowV.Cells[2].Text;
                    }
                }
            }
            catch
            {

            }
        }
        //Cancel button, Clean the textbox
        protected void btnCancelar_TpE_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oControles = new ArrayList();
            oControles.Add(txtIdTpE_TpE);
            oControles.Add(txtTpEquipo_TpE);
            oControles.Add(txtObserv_TpE);

            LimpiarCampos(oControles);

        }
        //Delete Button, logical delete put state in 0 on the database
        protected void btnEliminar_TpE_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            int idTipoEquipo = 0;
            try
            {
                if (!string.IsNullOrEmpty(txtIdTpE_TpE.Text))
                {
                    idTipoEquipo = Convert.ToInt32(txtIdTpE_TpE.Text);
                    EliminarTipoequipo(idTipoEquipo);

                    string tab = GetGlobalResourceObject("mantenimiento.language", "tipoequipo").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_TpEquipo, tab + message, 1);
                }
                else
                {
                    string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message1 = "";
                    showMessage(ltlMsg_TpEquipo, tab1 + message1, 2);
                }

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_TpEquipo, tab + message, 2);
            }
        }
        private void EliminarTipoequipo(int idTipoEquipo)
        {
            ArrayList oDatos = (ArrayList)Session["Usuario"];
            MantenimientoBLL.eliminarTipoEquipo(idTipoEquipo,oDatos[0].ToString());
            ltlMessage.Visible = true;
            FillGridViewTipoEquipo();

        }

        /////////////////////////////////////////////////////////////////////
        ///                   Tipo Equipo Part End                        ///
        /////////////////////////////////////////////////////////////////////
        ///

        /////////////////////////////////////////////////////////////////////
        ///                        Equipo Part Start                      ///
        /////////////////////////////////////////////////////////////////////

        private void FillGridViewEquipo()
        {
            try
            {
                grvEquipo_Eqp.DataSource = MantenimientoBLL.getEquipo();
                grvEquipo_Eqp.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Equipo, tab + message, 2);
            }
        }

        private void FillDdlEstado()
        {
            ddlEstado_Eqp.Items.Clear();
            ListItem oLstItemActivo = new ListItem("Activo", "1");
            ListItem oLstItemInactivo = new ListItem("Inactivo", "0");
            ddlEstado_Eqp.Items.Add(oLstItemInactivo);
            ddlEstado_Eqp.Items.Add(oLstItemActivo);
            ddlEstado_Eqp.SelectedValue = "1";

        }
        //Button Action to save or update
        protected void btnGuardar_Eqp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtCodigo_Eqp);
            olstCampos.Add(ddlEstado_Eqp);
            olstCampos.Add(ddlMarca_Eqp);
            olstCampos.Add(ddlTipoEquipo_Eqp);
            olstCampos.Add(ddlEspacio_Eqp);
            olstCampos.Add(ddlEncargado_Eqp);
            olstCampos.Add(ddlCondicion_Eqp);


            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarEquipo();

                ArrayList oControles = new ArrayList();
                oControles.Add(txtCodigo_Eqp);
                oControles.Add(txtPlaca_Eqp);
                oControles.Add(txtSerie_Eqp);
                oControles.Add(txtModelo_Eqp);
                oControles.Add(txtDescrip_Eqp);
                oControles.Add(txtCosto_Eqp);
                oControles.Add(txtObserv_Eqp);
                oControles.Add(ddlEstado_Eqp);
                oControles.Add(ddlMarca_Eqp);
                oControles.Add(ddlTipoEquipo_Eqp);
                oControles.Add(ddlEspacio_Eqp);
                oControles.Add(ddlEncargado_Eqp);
                oControles.Add(ddlCondicion_Eqp);

                LimpiarCampos(oControles);


                FillDownMarca(ddlMarca_Eqp);
                FillDownEspacio(ddlEspacio_Eqp);
                FillDownCondicion(ddlCondicion_Eqp);
                FillGridViewEquipo();
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Equipo, tab + message, 2);
            }

        }
        //Save and update method
        protected void GuardarEquipo()
        {
            try
            {
                Equipo oEquipo = new Equipo();

                oEquipo.idEquipo = txtCodigo_Eqp.Text;
                oEquipo.Placap = txtPlaca_Eqp.Text;
                oEquipo.Seriep = txtSerie_Eqp.Text;
                oEquipo.Estadop = Convert.ToString(ddlEstado_Eqp.SelectedValue);
                oEquipo.Marcap = Convert.ToString(ddlMarca_Eqp.SelectedValue);
                oEquipo.Modelop = txtModelo_Eqp.Text;
                oEquipo.Descripp = txtDescrip_Eqp.Text;
                oEquipo.TipoEquipop = Convert.ToString(ddlTipoEquipo_Eqp.SelectedValue);
                oEquipo.Costop = txtCosto_Eqp.Text;
                oEquipo.Espaciop = Convert.ToString(ddlEspacio_Eqp.SelectedValue);
                oEquipo.Encargadop = Convert.ToString(ddlEncargado_Eqp.SelectedValue);
                oEquipo.Condicionp = Convert.ToString(ddlCondicion_Eqp.SelectedValue);
                oEquipo.Observacionp = txtObserv_Eqp.Text;

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                MantenimientoBLL.GuardarEquipo(oEquipo,oDatos[0].ToString());
                FillGridViewEquipo();

                string tab = GetGlobalResourceObject("mantenimiento.language", "equipo").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Equipo, tab + message, 1);

                refrescarCampos();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Equipo, tab + message, 2);
            }
        }
        //Gridview button update and fills the textbox 
        protected void grvEquipo_Eqp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvEquipo_Eqp.Rows[index];

            try
            {
                if (e.CommandName == "Modificar")
                {

                    foreach (DataRow row in MantenimientoBLL.getEquipo(rowV.Cells[0].Text).Rows)
                    {
                        txtCodigo_Eqp.Text = row[0].ToString();
                        txtPlaca_Eqp.Text = row[1].ToString();
                        txtSerie_Eqp.Text = row[2].ToString();
                        ddlMarca_Eqp.SelectedValue = row[3].ToString();
                        txtModelo_Eqp.Text = row[5].ToString();
                        txtDescrip_Eqp.Text = row[6].ToString();
                        ddlTipoEquipo_Eqp.SelectedValue = row[7].ToString();
                        txtCosto_Eqp.Text = row[9].ToString();
                        ddlEspacio_Eqp.SelectedValue = row[10].ToString();
                        ddlEncargado_Eqp.SelectedValue = row[12].ToString();
                        ddlCondicion_Eqp.SelectedValue = row[14].ToString();
                        txtObserv_Eqp.Text = row[16].ToString();
                        ddlEstado_Eqp.SelectedValue = row["estado"].ToString();
                    }

                }
            }
            catch
            {
            }
        }
        //Cancel button, Clean the textbox
        protected void btnCancelar_Eqp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();

            ArrayList oControles = new ArrayList();
            oControles.Add(txtCodigo_Eqp);
            oControles.Add(txtPlaca_Eqp);
            oControles.Add(txtSerie_Eqp);
            oControles.Add(txtModelo_Eqp);
            oControles.Add(txtDescrip_Eqp);
            oControles.Add(txtCosto_Eqp);
            oControles.Add(txtObserv_Eqp);
            oControles.Add(ddlEstado_Eqp);
            oControles.Add(ddlMarca_Eqp);
            oControles.Add(ddlTipoEquipo_Eqp);
            oControles.Add(ddlEspacio_Eqp);
            oControles.Add(ddlEncargado_Eqp);
            oControles.Add(ddlCondicion_Eqp);

            LimpiarCampos(oControles);
        }
        //Delete Button, logical delete put state in 0 on the database
        protected void btnEliminar_Eqp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            string idEquipo = "";
            try
            {
                if (!String.IsNullOrEmpty(txtCodigo_Eqp.Text))
                {
                    idEquipo = txtCodigo_Eqp.Text;
                    EliminarEquipo(idEquipo);

                    string tab = GetGlobalResourceObject("mantenimiento.language", "equipo").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Equipo, tab + message, 1);
                }
                else
                {
                    string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message1 = "";
                    showMessage(ltlMsg_Equipo, tab1 + message1, 2);
                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Equipo, tab + message, 2);
            }

        }
        private void EliminarEquipo(string idEquipo)
        {
            ArrayList oDatos = (ArrayList)Session["Usuario"];
            MantenimientoBLL.eliminarEquipo(idEquipo,oDatos[0].ToString());
            FillGridViewEquipo();
        }

        /////////////////////////////////////////////////////////////////////
        ///                       Equipo Part End                         ///
        /////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////
        ///                       Espacio Part Start                      ///
        /////////////////////////////////////////////////////////////////////

        private void FillGridViewEspacio()
        {
            try
            {
                grvEspacios_Esp.DataSource = MantenimientoBLL.getEspacio();
                grvEspacios_Esp.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Espacios, tab + message, 2);
            }
        }
        //Button Action to save or update
        protected void btnAgregar_Esp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();

            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtCantidad_Esp);
            olstCampos.Add(ddlTipoEqp_Esp);


            if (revisarCampos(olstCampos) == olstCampos.Count)
            {

                TipoEquipoEspacio oTipoEquipoEspacio = new TipoEquipoEspacio();
                oTipoEquipoEspacio.cantidad = Convert.ToInt32(txtCantidad_Esp.Text);
                oTipoEquipoEspacio.idTipoEquipo = Convert.ToInt32(ddlTipoEqp_Esp.SelectedItem.Value);
                oTipoEquipoEspacio.descripcion = ddlTipoEqp_Esp.SelectedItem.Text;
                oTipoEquipoEspacio.observaciones = txtObserv_Esp.Text;

                foreach (TipoEquipoEspacio item in oLstTipoEquipoEspacio)
                {
                    if (item.idTipoEquipo == Convert.ToInt32(ddlTipoEqp_Esp.SelectedItem.Value))
                    {
                        item.descripcion = ddlTipoEqp_Esp.SelectedItem.Text;
                        item.cantidad = Convert.ToInt32(txtCantidad_Esp.Text);
                        item.observaciones = txtObserv_Esp.Text;
                    }
                }

                if (!oLstTipoEquipoEspacio.Exists(x => x.idTipoEquipo == Convert.ToInt32(ddlTipoEqp_Esp.SelectedItem.Value)))
                {
                    oLstTipoEquipoEspacio.Add(oTipoEquipoEspacio);
                }


                lstEquipos_Esp.DataSource = oLstTipoEquipoEspacio;
                lstEquipos_Esp.DataBind();

                ArrayList oControles = new ArrayList();
                oControles.Add(txtCantidad_Esp);
                oControles.Add(ddlTipoEqp_Esp);
                oControles.Add(txtObserv_Esp);
                LimpiarCampos(oControles);
            }
        }

        //Button Action to save or update
        protected void btnDetail_Esp_Click(object sender, EventArgs e)
        {

        }
        //Button Action to save or update
        protected void btnGuardar_Esp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtEspacio_Esp);
            olstCampos.Add(ddlEncargado_Eqp);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarEspacio();
                ArrayList oControles = new ArrayList();
                oControles.Add(txtCodigo_Esp);
                oControles.Add(txtEspacio_Esp);
                oControles.Add(txtUbicacion_Esp);
                LimpiarCampos(oControles);
                oLstTipoEquipoEspacio.Clear();
                lstEquipos_Esp.Items.Clear();
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Espacios, tab + message, 2);
            }
        }
        //Save and update method
        protected void GuardarEspacio()
        {
            try
            {
                Espacio oEspacio = new Espacio();
                try
                {
                    oEspacio.idEspacio = Convert.ToInt32(txtCodigo_Esp.Text);
                }
                catch (Exception)
                {
                    oEspacio.idEspacio = 0;
                }
                oEspacio.Espaciop = txtEspacio_Esp.Text;
                oEspacio.Ubicacion = txtUbicacion_Esp.Text;
                oEspacio.idEncargado = Convert.ToString(ddlEncargado_Esp.SelectedValue);

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                MantenimientoBLL.GuardarEspacio(oEspacio, oLstTipoEquipoEspacio,oDatos[0].ToString());
                FillGridViewEspacio();

                string tab = GetGlobalResourceObject("mantenimiento.language", "espacios").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Espacios, tab + message, 1);

                refrescarCampos();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Espacios, tab + message, 2);
            }
        }
        //Gridview button update and fills the textbox 
        protected void grvEspacios_Esp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvEspacios_Esp.Rows[index];
            string Id = grvEspacios_Esp.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar")
                {


                    foreach (DataRow row in MantenimientoBLL.getEspacio(Id).Rows)
                    {
                        txtCodigo_Esp.Text = Id;
                        txtEspacio_Esp.Text = row["Espacio"].ToString();
                        txtUbicacion_Esp.Text = row["ubicacion"].ToString();
                        ddlEncargado_Esp.SelectedValue = row["numero_Identificacion"].ToString();
                    }

                    foreach (DataRow row in MantenimientoBLL.getEspacioTipoEquipoDetail(Convert.ToInt32(Id)).Rows)
                    {
                        TipoEquipoEspacio oTipoEquipoEspacio = new TipoEquipoEspacio();
                        oTipoEquipoEspacio.cantidad = Convert.ToInt32(row["cantidad"].ToString());
                        oTipoEquipoEspacio.idTipoEquipo = Convert.ToInt32(row["idTipoEquipo"].ToString());
                        oTipoEquipoEspacio.descripcion = row["tipoEquipo"].ToString();
                        oLstTipoEquipoEspacio.Add(oTipoEquipoEspacio);

                        lstEquipos_Esp.DataSource = oLstTipoEquipoEspacio;
                        lstEquipos_Esp.DataBind();
                    }
                }

            }
            catch
            {
            }
        }
        //Gridview button update and fills the textbox 
        protected void grvEspaciosTipoEquipo_Esp_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            //GridViewRow rowV = grvEspaciosTipoEquipo_Esp.Rows[index];

        }
        //Cancel button, Clean the textbox
        protected void btnCancelar_Esp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oControles = new ArrayList();
            oControles.Add(txtCodigo_Esp);
            oControles.Add(txtEspacio_Esp);
            oControles.Add(txtUbicacion_Esp);
            LimpiarCampos(oControles);
            lstEquipos_Esp.Items.Clear();
        }
        //Delete Button, logical delete put state in 0 on the database
        protected void btnEliminar_Esp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            int idEspacio = 0;
            try
            {
                if (!string.IsNullOrEmpty(txtCodigo_Esp.Text))
                {
                    idEspacio = Convert.ToInt32(txtCodigo_Esp.Text);
                    EliminarEspacio(idEspacio);

                    string tab = GetGlobalResourceObject("mantenimiento.language", "espacios").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Espacios, tab + message, 1);
                }
                else
                {
                    string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message1 = "";
                    showMessage(ltlMsg_Espacios, tab1 + message1, 2);
                }
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Espacios, tab + message, 2);
            }
        }
        private void EliminarEspacio(int idEspacio)
        {
            ArrayList oDatos = (ArrayList)Session["Usuario"];
            MantenimientoBLL.eliminarEspacio(idEspacio,oDatos[0].ToString());
            FillGridViewEspacio();
        }

        protected void lstEquipos_Esp_SelectedIndexChanged(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (lstEquipos_Esp.SelectedIndex != -1)
            {
                btnEliminarTp_esp.Visible = true;
                foreach (TipoEquipoEspacio item in oLstTipoEquipoEspacio)
                {
                    if (lstEquipos_Esp.SelectedItem.Text.Equals(item.cantidad + " - " + item.descripcion))
                    {
                        txtCantidad_Esp.Text = item.cantidad.ToString();
                        ddlTipoEqp_Esp.SelectedValue = item.idTipoEquipo.ToString();
                        txtObserv_Esp.Text = item.observaciones;
                    }
                }
            }
        }

        protected void btnEliminarTp_esp_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (lstEquipos_Esp.SelectedIndex != -1)
            {
                oLstTipoEquipoEspacio.RemoveAt(lstEquipos_Esp.SelectedIndex);
                lstEquipos_Esp.DataSource = oLstTipoEquipoEspacio;
                lstEquipos_Esp.DataBind();
                ArrayList oControles = new ArrayList();
                oControles.Add(txtCantidad_Esp);
                oControles.Add(ddlTipoEqp_Esp);
                oControles.Add(txtObserv_Esp);
                LimpiarCampos(oControles);
                btnEliminarTp_esp.Visible = false;
            }
        }

        /////////////////////////////////////////////////////////////////////
        ///                      Espacio Part End                         ///
        /////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////
        ///                   Institucion Part Start                      ///
        /////////////////////////////////////////////////////////////////////

        private void FillGridViewInstitucion()
        {
            try
            {
                grvInstituciones_Ins.DataSource = MantenimientoBLL.getInstitucion();
                grvInstituciones_Ins.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Ins, tab + message, 2);
            }
        }
        //Button Action to save or update
        protected void btnGuardar_Ins_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtInst_Ins);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarInstitucion();

                ArrayList oControles = new ArrayList();
                oControles.Add(txtId_Ins);
                oControles.Add(txtInst_Ins);
                oControles.Add(txtObserv_Ins);
                LimpiarCampos(oControles);
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Ins, tab + message, 2);
            }
        }
        //Save and update method
        protected void GuardarInstitucion()
        {
            try
            {
                Instituciones oInstitucion = new Instituciones();
                try
                {
                    oInstitucion.idInstitucion = Convert.ToInt32(txtId_Ins.Text);
                }
                catch (Exception)
                {
                    oInstitucion.idInstitucion = 0;
                }
                oInstitucion.nombre_institucion = txtInst_Ins.Text;
                oInstitucion.observaciones = txtObserv_Ins.Text;

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                MantenimientoBLL.GuardarInstitucion(oInstitucion,oDatos[0].ToString());
                FillGridViewInstitucion();

                string tab = GetGlobalResourceObject("mantenimiento.language", "institucion").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Ins, tab + message, 1);

                refrescarCampos();

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Ins, tab + message, 2);
            }
        }
        //Gridview button update and fills the textbox 
        protected void grvInstitucion_Ins_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvInstituciones_Ins.Rows[index];
            string Id = grvInstituciones_Ins.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar3")
                {
                    txtId_Ins.Text = Id;
                    txtInst_Ins.Text = rowV.Cells[1].Text;
                    if (rowV.Cells[2].Text.Equals("&nbsp;"))
                    {
                        txtObserv_Ins.Text = "";
                    }
                    else
                    {
                        txtObserv_Ins.Text = rowV.Cells[2].Text;
                    }
                }
            }
            catch
            {

            }
        }
        //Cancel button, Clean the textbox
        protected void btnCancelar_Ins_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oControles = new ArrayList();
            oControles.Add(txtId_Ins);
            oControles.Add(txtInst_Ins);
            oControles.Add(txtObserv_Ins);
            LimpiarCampos(oControles);
        }
        //Delete Button, logical delete put state in 0 on the database
        protected void btnEliminar_Ins_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            int idInstitucion = 0;
            try
            {
                if (!string.IsNullOrEmpty(txtId_Ins.Text))
                {
                    idInstitucion = Convert.ToInt32(txtId_Ins.Text);
                    EliminarInstitucion(idInstitucion);

                    string tab = GetGlobalResourceObject("mantenimiento.language", "institucion").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Ins, tab + message, 1);
                }
                else
                {
                    string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message1 = "";
                    showMessage(ltlMsg_Ins, tab1 + message1, 2);
                }
                

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Ins, tab + message, 2);
            }
        }
        private void EliminarInstitucion(int idInstitucion)
        {
            ArrayList oDatos = (ArrayList)Session["Usuario"];
            MantenimientoBLL.eliminarInstitucion(idInstitucion,oDatos[0].ToString());
            FillGridViewInstitucion();
        }

        /////////////////////////////////////////////////////////////////////
        ///                   Institucion Part End                        ///
        /////////////////////////////////////////////////////////////////////
        ///
        /////////////////////////////////////////////////////////////////////
        ///                      Marcas Part Start                        ///
        /////////////////////////////////////////////////////////////////////

        private void FillGridViewMarca()
        {
            try
            {
                grvMarcas_Mrc.DataSource = MantenimientoBLL.getMarca();
                grvMarcas_Mrc.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Marcas, tab + message, 2);
            }
        }
        //Button Action to save or update
        protected void btnGuardar_Mrc_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtMarca_Mrc);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarMarcas();

                ArrayList oControles = new ArrayList();
                oControles.Add(txtId_Mrc);
                oControles.Add(txtMarca_Mrc);
                oControles.Add(txtObserv_Mrc);
                LimpiarCampos(oControles);
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Marcas, tab + message, 2);
            }
        }
        //Save and update method
        protected void GuardarMarcas()
        {
            try
            {
                MarcaEquipo oMarca = new MarcaEquipo();
                try
                {
                    oMarca.idMarcaEquipo = Convert.ToInt32(txtId_Mrc.Text);
                }
                catch (Exception)
                {
                    oMarca.idMarcaEquipo = 0;
                }
                oMarca.Marca = txtMarca_Mrc.Text;
                oMarca.observaciones = txtObserv_Mrc.Text;

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                MantenimientoBLL.GuardarMarcaEquipo(oMarca, oDatos[0].ToString());
                FillGridViewMarca();

                string tab = GetGlobalResourceObject("mantenimiento.language", "marcas").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Marcas, tab + message, 1);

                refrescarCampos();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Marcas, tab + message, 2);
            }
        }
        //Gridview button update and fills the textbox 
        protected void grvMarca_Mrc_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvMarcas_Mrc.Rows[index];
            string Id = grvMarcas_Mrc.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar")
                {
                    txtId_Mrc.Text = Id;
                    txtMarca_Mrc.Text = rowV.Cells[1].Text;
                    if (rowV.Cells[2].Text.Equals("&nbsp;"))
                    {
                        txtObserv_Mrc.Text = "";
                    }
                    else
                    {
                        txtObserv_Mrc.Text = rowV.Cells[2].Text;
                    }
                }
            }
            catch
            {

            }
        }
        //Cancel button, Clean the textbox
        protected void btnCancelar_Mrc_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oControles = new ArrayList();
            oControles.Add(txtId_Mrc);
            oControles.Add(txtMarca_Mrc);
            oControles.Add(txtObserv_Mrc);
            LimpiarCampos(oControles);
        }
        //Delete Button, logical delete put state in 0 on the database
        protected void btnEliminar_Mrc_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            int idMarca = 0;
            try
            {
                if (!string.IsNullOrEmpty(txtId_Mrc.Text))
                {
                    idMarca = Convert.ToInt32(txtId_Mrc.Text);
                    EliminarMarca(idMarca);

                    string tab = GetGlobalResourceObject("mantenimiento.language", "marcas").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Marcas, tab + message, 1);
                }
                else
                {
                    string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message1 = "";
                    showMessage(ltlMsg_Marcas, tab1 + message1, 2);
                }
                

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Marcas, tab + message, 2);
            }
        }
        private void EliminarMarca(int idMarca)
        {
            ArrayList oDatos = (ArrayList)Session["Usuario"];
            MantenimientoBLL.eliminarMarcaEquipo(idMarca,oDatos[0].ToString());
            FillGridViewMarca();
        }

        /////////////////////////////////////////////////////////////////////
        ///                      Marcas Part End                          ///
        /////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////
        ///                     Condicion Part Start                      ///
        /////////////////////////////////////////////////////////////////////

        private void FillGridViewCondicion()
        {
            try
            {
                grvCondicion_Cnd.DataSource = MantenimientoBLL.getCondicion();
                grvCondicion_Cnd.DataBind();
            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMsg_Condicion, tab + message, 2);
            }
        }
        //Button Action to save or update
        protected void btnGuardar_Cnd_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList olstCampos = new ArrayList();

            olstCampos.Add(txtCondicion_Cnd);

            if (revisarCampos(olstCampos) == olstCampos.Count)
            {
                GuardarCondicion();

                ArrayList oControles = new ArrayList();
                oControles.Add(txtId_Cnd);
                oControles.Add(txtCondicion_Cnd);
                oControles.Add(txtObservaciones_Cnd);
                LimpiarCampos(oControles);
            }
            else
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "fillAll").ToString();
                string message = "";
                showMessage(ltlMsg_Condicion, tab + message, 2);
            }
        }
        //Save and update method
        protected void GuardarCondicion()
        {
            try
            {
                Condicion oCondicion = new Condicion();
                try
                {
                    oCondicion.idCondicion = Convert.ToInt32(txtId_Cnd.Text);
                }
                catch (Exception)
                {
                    oCondicion.idCondicion = 0;
                }
                oCondicion.Condicionp = txtCondicion_Cnd.Text;
                oCondicion.observaciones = txtObservaciones_Cnd.Text;

                ArrayList oDatos = (ArrayList)Session["Usuario"];

                MantenimientoBLL.GuardarCondicion(oCondicion,oDatos[0].ToString());
                FillGridViewCondicion();

                string tab = GetGlobalResourceObject("mantenimiento.language", "condicion").ToString();
                string message = GetGlobalResourceObject("Mensajes.language", "GuardadoCorrecto").ToString();
                showMessage(ltlMsg_Condicion, tab + message, 1);

                refrescarCampos();

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "guardarError").ToString();
                string message = "";
                showMessage(ltlMsg_Condicion, tab + message, 2);
            }
        }
        //Gridview button update and fills the textbox 
        protected void grvCondicion_Cnd_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvCondicion_Cnd.Rows[index];
            string Id = grvCondicion_Cnd.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar")
                {
                    txtId_Cnd.Text = Id;
                    txtCondicion_Cnd.Text = rowV.Cells[1].Text;
                    if (rowV.Cells[2].Text.Equals("&nbsp;"))
                    {
                        txtObservaciones_Cnd.Text = "";
                    }
                    else
                    {
                        txtObservaciones_Cnd.Text = rowV.Cells[2].Text;
                    }
                }
            }
            catch
            {

            }
        }
        //Cancel button, Clean the textbox
        protected void btnCancelar_Cnd_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            txtId_Cnd.Text = "";
            txtCondicion_Cnd.Text = "";
            txtObservaciones_Cnd.Text = "";

            ArrayList oControles = new ArrayList();
            oControles.Add(txtId_Cnd);
            oControles.Add(txtCondicion_Cnd);
            oControles.Add(txtObservaciones_Cnd);
            LimpiarCampos(oControles);
        }
        //Delete Button, logical delete put state in 0 on the database
        protected void btnEliminar_Cnd_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            int idCondicion = 0;
            try
            {
                if (!string.IsNullOrEmpty(txtId_Cnd.Text))
                {
                    idCondicion = Convert.ToInt32(txtId_Cnd.Text);
                    EliminarCondicion(idCondicion);

                    string tab = GetGlobalResourceObject("mantenimiento.language", "condicion").ToString();
                    string message = GetGlobalResourceObject("Mensajes.language", "EliminadoCorrecto").ToString();
                    showMessage(ltlMsg_Condicion, tab + message, 1);
                }
                else
                {
                    string tab1 = GetGlobalResourceObject("Mensajes.language", "selectOne").ToString();
                    string message1 = "";
                    showMessage(ltlMsg_Condicion, tab1 + message1, 2);
                }
                

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "eliminarError").ToString();
                string message = "";
                showMessage(ltlMsg_Condicion, tab + message, 2);
            }
        }
        private void EliminarCondicion(int idCondicion)
        {
            ArrayList oDatos = (ArrayList)Session["Usuario"];
            MantenimientoBLL.eliminarCondicion(idCondicion,oDatos[0].ToString());
            FillGridViewCondicion();
        }

        /////////////////////////////////////////////////////////////////////
        ///                    Condicion Part End                         ///
        /////////////////////////////////////////////////////////////////////

        /////////////////////////////////////////////////////////////////////
        ///                       Common Function                         ///
        /////////////////////////////////////////////////////////////////////
        /// Selected Color Changing function

        // ddl Encargado
        private void FillDownEncargado(DropDownList ddlEncargado)
        {
            try
            {
                ddlEncargado.Items.Clear();
                ddlEncargado.DataSource = MantenimientoBLL.getEncargadoDDL();
                ddlEncargado.DataValueField = "numero_Identificacion";
                ddlEncargado.DataTextField = "nombre_Completo";
                ddlEncargado.DataBind();
                //ddlEncargado.Items.Insert(0, (GetGlobalResourceObject("seguridad.language", "ddlSelect").ToString()));

            }
            catch (Exception)
            {

                throw;
            }
        }
        // ddl Encargado
        private void FillDownTipoEquipo(DropDownList ddlTipoEquipo)
        {
            try
            {
                ddlTipoEquipo.Items.Clear();
                ddlTipoEquipo.DataSource = MantenimientoBLL.getTipoEquipo();
                ddlTipoEquipo.DataValueField = "idTipoEquipo";
                ddlTipoEquipo.DataTextField = "tipoEquipo";
                ddlTipoEquipo.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }
        // ddl Estado
        private void FillDownEstado(DropDownList ddlEstado)
        {
            try
            {

            }
            catch (Exception)
            {

                throw;
            }
        }
        // ddl Marca
        private void FillDownMarca(DropDownList ddlMarca)
        {
            try
            {
                ddlMarca.Items.Clear();
                ddlMarca.DataSource = MantenimientoBLL.getMarca();
                ddlMarca.DataValueField = "idMarca";
                ddlMarca.DataTextField = "marca";
                ddlMarca.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }
        // ddl Espacio
        private void FillDownEspacio(DropDownList ddlEspacio)
        {
            try
            {
                ddlEspacio.Items.Clear();
                ddlEspacio.DataSource = MantenimientoBLL.getEspacio();
                ddlEspacio.DataValueField = "idEspacio";
                ddlEspacio.DataTextField = "Espacio";
                ddlEspacio.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }
        // ddl Condicion
        private void FillDownCondicion(DropDownList ddlCondicion)
        {
            try
            {
                ddlCondicion.Items.Clear();
                ddlCondicion.DataSource = MantenimientoBLL.getCondicion();
                ddlCondicion.DataValueField = "idCondicion";
                ddlCondicion.DataTextField = "Condicion";
                ddlCondicion.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }
        // lst Equipos
        private void FillDownListTipoEquipo(ListBox lstEquipos, int idEspacio)
        {
            try
            {
                lstEquipos.Items.Clear();
                lstEquipos.DataSource = MantenimientoBLL.getListTipoEquipo(idEspacio);
                lstEquipos.DataValueField = "idTipoEquipo";
                lstEquipos.DataTextField = "tipoEquipo";
                lstEquipos.DataBind();
                //ddlEncargado.Items.Insert(0, (GetGlobalResourceObject("seguridad.language", "ddlSelect").ToString()));

            }
            catch (Exception)
            {

                throw;
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

        private void LimpiarCampos(ArrayList campos)
        {
            foreach (Control ctrl in campos)
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

                }
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

            StringBuilder builder = new StringBuilder();

            builder.Append("window.setTimeout(function () {");
            builder.Append("$('.alert').fadeTo(1, 0).slideUp(400, function () {");
            builder.Append("$(this).remove();");
            builder.Append("});");
            builder.Append("}, 5000);");

            ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "tmp", builder.ToString(), true);
        }

        private void LimpiarMensajes()
        {
            ltlMsg_Puesto.Text = "";
            ltlMsg_TpEquipo.Text = "";
            ltlMsg_Equipo.Text = "";
            ltlMsg_Espacios.Text = "";
            ltlMsg_Ins.Text = "";
            ltlMsg_Marcas.Text = "";
            ltlMsg_Condicion.Text = "";
        }
    }
}