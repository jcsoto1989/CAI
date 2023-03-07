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
using System.Data.OleDb;
using System.IO;
using System.Windows;
using System.Windows.Shell;

namespace slnCAI
{
    public partial class Procesos : System.Web.UI.Page
    {
        public static List<DiasEvento> olstDias;

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
            /*
            ltlMessage.Text = "";
            ltlMessage.Visible = false;*/

        }

        private void crearTabs(string idRol)
        {
            StringBuilder oTabs = new StringBuilder();

            try
            {
                DataTable dt = SeguridadBLL.getMenu(Convert.ToInt32(idRol), "Procesos");
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
                            case "tabEventos1":
                                tabEventos1.Visible = true;
                                llenarComboPeriodo(ddlPeriodo_Evt, 1);
                                llenarComboTipoEvento(ddl_MdlEvento_TipoEvento, 1);
                                llenarComboEvento(ddlEvento_Evt, 1);
                                obtenerEvento(1);
                                llenarComboTipoIdentificacion(ddlTipoIdentificacion_Evento, 1);
                                llenarComboEspacio(ddlEspacio);
                                AgregarFechasDataBase();
                                llenarComboInstitucion();
                                break;
                            case "tabPersona1":
                                llenarGridPersona();
                                llenarComboTipoIdentificacion(ddlTpId_Persona, 1);
                                llenarComboPais();
                                break;

                            case "tabInscripcion1":
                                llenarComboPersonasInscripcion();
                                ddlPersonasInscripcion.SelectedIndex = -1;
                                llenarComboPeriodo(ddlPeriodo_Inscrip, 1);
                                llenarComboPeriodo(ddlPeriodo_MdlExcel, 1);
                                llenarComboEvento(ddlEvento_Inscrip, 1);
                                llenarComboEvento(ddlEvento_MdlExcel, 1);
                                if (ddlEvento_Inscrip.SelectedIndex >= 0 && ddlPeriodo_Inscrip.SelectedIndex >= 0)
                                {
                                    obtenerMatriculados(ddlEvento_Inscrip.SelectedValue, ddlPeriodo_Inscrip.SelectedValue);
                                }

                                break;


                            case "tabPeriodo1":
                                obtenerPeriodo(1);


                                break;
                            case "tabTipoEvento1":
                                obtenerTipoEvento(1);
                                break;

                            case "tabAsistencia1":
                                llenarComboEvento(ddlEvento_Asistencia, 1);
                                llenarComboPeriodo(ddlPeriodo_Asistencia, 1);
                                llenarComboTipoIdentificacion(ddlTipoIdentificacion_Asistencia, 1);
                                int idEvento, idPeriodo;
                                if (ddlEvento_Asistencia.SelectedIndex >= 0)
                                {
                                    idEvento = Convert.ToInt32(ddlEvento_Asistencia.SelectedValue);
                                }
                                else
                                {
                                    idEvento = 0;
                                }

                                if (ddlPeriodo_Asistencia.SelectedIndex >= 0)
                                {
                                    idPeriodo = Convert.ToInt32(ddlPeriodo_Asistencia.SelectedValue);
                                }
                                else
                                {
                                    idPeriodo = 0;
                                }

                                llenarComboFechaAsistencias(idEvento, idPeriodo);

                                cambiarMascara(mskIdPersona_Asistencia, ddlTipoIdentificacion_Asistencia);
                                txtNumPC_MaskedEditExtender.Mask = "99";
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
                    ProcesosPage.Visible = false;
                }

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMessage, tab + message, 2);

            }
        }
        private void llenarComboPersonasInscripcion()
        {
            try
            {
                ddlPersonasInscripcion.DataSource = ProcesosBLL.obtenerPersonaIdentificacion();
                ddlPersonasInscripcion.DataTextField = "numero_identificacion";
                ddlPersonasInscripcion.DataBind();

            }
            catch (Exception)
            {

                throw;
            }
        }

        /*******************************************************************************************/
        /**********                             Pestaña Evento-Espacio                    **********/
        /*******************************************************************************************/
        protected void btnGuardarFechasEvento_Click(object sender, EventArgs e)
        {
            ArrayList lstEspacioEvento = new ArrayList();

            for (int i = 0; i < grvFechasEvento.Rows.Count; i++)
            {
                EspacioEvento oEspacioEvento = new EspacioEvento();
                oEspacioEvento.idEvento = Convert.ToInt32(ddlEvento_Evt.SelectedValue);
                oEspacioEvento.idPeriodo = Convert.ToInt32(ddlPeriodo_Evt.SelectedValue);
                oEspacioEvento.idTipoIdpersona = Convert.ToInt32(ddlTipoIdentificacion_Evento.SelectedValue);

                DropDownList Espacio = (DropDownList)grvFechasEvento.Rows[i].Cells[1].FindControl("ddlEspacio_grvEvt");
                TextBox Fechatxt = (TextBox)grvFechasEvento.Rows[i].Cells[2].FindControl("txtFecha");
                TextBox horaIniciotxt = (TextBox)grvFechasEvento.Rows[i].Cells[3].FindControl("txtHoraInicio");
                TextBox horaFinaltxt = (TextBox)grvFechasEvento.Rows[i].Cells[4].FindControl("txtHoraFinal");
                TextBox Encargadotxt = (TextBox)grvFechasEvento.Rows[i].Cells[5].FindControl("txtCedulaEncargado");
                CheckBox chk = (CheckBox)grvFechasEvento.Rows[i].Cells[6].FindControl("chkControlPC_grvEspacio");

                oEspacioEvento.idEspacio = Convert.ToInt32(Espacio.SelectedValue);
                oEspacioEvento.fecha = Fechatxt.Text;
                oEspacioEvento.horaInicio = horaIniciotxt.Text;
                oEspacioEvento.horaFinal = horaFinaltxt.Text;
                oEspacioEvento.idEncargado = Encargadotxt.Text;
                oEspacioEvento.ControlPC = chk.Checked;

                lstEspacioEvento.Add(oEspacioEvento);
            }

            try
            {
                ProcesosBLL.GuardarEspacioEvento(lstEspacioEvento, Convert.ToInt32(ddlEvento_Evt.SelectedValue), Convert.ToInt32(ddlPeriodo_Evt.SelectedValue));
                showMessage(ltlMessage, "Fechas Agregadas correctamente", 1);

                DataTable dt = new DataTable();
                grvFechasEvento.DataSource = dt;
                grvFechasEvento.DataBind();


                LimpiarCampos(tabEventos1.Controls);
                AgregarFechasDataBase();
            }
            catch (Exception ex)
            {
                showMessage(ltlMessage, ex.ToString(), 2);
                throw;
            }
        }

        private void AgregarFechasDataBase()
        {
            ViewState["CurrentTable"] = null;
            try
            {
                int idEvento = 0, idPeriodo = 0;
                if (ddlEvento_Evt.SelectedIndex >= 0)
                {
                    idEvento = Convert.ToInt32(ddlEvento_Evt.SelectedValue);
                }

                if (ddlPeriodo_Evt.SelectedIndex >= 0)
                {
                    idPeriodo = Convert.ToInt32(ddlPeriodo_Evt.SelectedValue);
                }


                DataTable dt = ProcesosBLL.obtenerEspacioEvento(idEvento, idPeriodo);

                if (dt.Rows.Count != 0)
                {
                    bool controlPCp = true;

                    foreach (DataRow oRow in dt.Rows)
                    {
                        if (string.IsNullOrEmpty(oRow["controlPC"].ToString()))
                        {
                            controlPCp = false;
                        }
                        else
                        {
                            switch (Convert.ToBoolean(oRow["controlPC"].ToString()))
                            {

                                case false:
                                    controlPCp = false;
                                    break;

                                case true:
                                    controlPCp = true;
                                    break;
                                default:
                                    controlPCp = true;
                                    break;
                            }
                        }

                        AddNewRowToGrid(Convert.ToDateTime(oRow["Column2"].ToString()), TimeSpan.Parse(oRow["Column3"].ToString()), TimeSpan.Parse(oRow["Column4"].ToString()), Convert.ToInt32(oRow["idTipoId"].ToString()), oRow["Column5"].ToString(), oRow["idEspacio"].ToString(), controlPCp);
                    }
                }
                else
                {
                    DataTable dt1 = new DataTable();
                    ViewState["CurrentTable"] = dt;
                    grvFechasEvento.DataSource = dt;
                    grvFechasEvento.DataBind();
                }

            }
            catch (Exception)
            {

                throw;
            }
        }
        private void SetInitialRow()
        {
            DataTable dt = new DataTable();
            DataRow dr = null;
            dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
            dt.Columns.Add(new DataColumn("Column1", typeof(string)));
            dt.Columns.Add(new DataColumn("Column2", typeof(string)));
            dt.Columns.Add(new DataColumn("Column3", typeof(string)));
            dt.Columns.Add(new DataColumn("Column4", typeof(string)));
            dt.Columns.Add(new DataColumn("Column5", typeof(string)));
            dr = dt.NewRow();
            dr["RowNumber"] = 1;
            dr["Column1"] = string.Empty;
            dr["Column2"] = string.Empty;
            dr["Column3"] = string.Empty;
            dr["Column4"] = string.Empty;
            dr["Column5"] = string.Empty;
            dt.Rows.Add(dr);
            //dr = dt.NewRow();
            //Store the DataTable in ViewState
            ViewState["CurrentTable"] = dt;
            grvFechasEvento.DataSource = dt;
            grvFechasEvento.DataBind();

        }

        private void AddNewRowToGrid()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
                DataRow drCurrentRow = null;
                if (dtCurrentTable.Rows.Count > 0)
                {
                    for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                    {
                        //extract the TextBox values
                        DropDownList box1 = (DropDownList)grvFechasEvento.Rows[rowIndex].Cells[1].FindControl("ddlEspacio_grvEvt");
                        TextBox box2 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[2].FindControl("txtFecha");
                        TextBox box3 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[3].FindControl("txtHoraInicio");
                        TextBox box4 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[3].FindControl("txtHoraFinal");
                        TextBox box5 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[3].FindControl("txtCedulaEncargado");
                        drCurrentRow = dtCurrentTable.NewRow();
                        drCurrentRow["RowNumber"] = i + 1;
                        dtCurrentTable.Rows[i - 1]["Column1"] = box1.Text;
                        dtCurrentTable.Rows[i - 1]["Column2"] = box2.Text;
                        dtCurrentTable.Rows[i - 1]["Column3"] = box3.Text;
                        dtCurrentTable.Rows[i - 1]["Column4"] = box4.Text;
                        dtCurrentTable.Rows[i - 1]["Column5"] = box5.Text;
                        rowIndex++;
                    }
                    dtCurrentTable.Rows.Add(drCurrentRow);
                    ViewState["CurrentTable"] = dtCurrentTable;
                    grvFechasEvento.DataSource = dtCurrentTable;
                    grvFechasEvento.DataBind();
                }
            }
            else
            {
                Response.Write("ViewState is null");
            }

            //Set Previous Data on Postbacks
            SetPreviousData();
        }

        private void SetPreviousData()
        {
            int rowIndex = 0;
            if (ViewState["CurrentTable"] != null)
            {
                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        DropDownList box1 = (DropDownList)grvFechasEvento.Rows[rowIndex].Cells[1].FindControl("ddlEspacio_grvEvt");
                        TextBox box2 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[2].FindControl("txtFecha");
                        TextBox box3 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[3].FindControl("txtHoraInicio");
                        TextBox box4 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[4].FindControl("txtHoraFinal");
                        TextBox box5 = (TextBox)grvFechasEvento.Rows[rowIndex].Cells[5].FindControl("txtCedulaEncargado");
                        CheckBox chk = (CheckBox)grvFechasEvento.Rows[rowIndex].Cells[6].FindControl("chkControlPC_grvEspacio");
                        llenarComboEspacio(box1);
                        box1.SelectedValue = ddlEspacio.SelectedValue;
                        box1.Text = dt.Rows[i]["Column1"].ToString();
                        box2.Text = dt.Rows[i]["Column2"].ToString();
                        box3.Text = dt.Rows[i]["Column3"].ToString();
                        box4.Text = dt.Rows[i]["Column4"].ToString();
                        box5.Text = dt.Rows[i]["Column5"].ToString();
                        chk.Checked = Convert.ToBoolean(dt.Rows[i]["ControlPC"].ToString());

                        rowIndex++;
                    }
                }
            }
        }

        protected void ButtonAdd_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            //testDays();
            AddNewRowToGrid();
        }

        protected void btnAgregarfecha_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtFechaInicio_Evt);
            oCampos.Add(txtFechaFinal_Evt);
            oCampos.Add(txtHoraInicio);
            oCampos.Add(txtHoraFinal);
            oCampos.Add(txtIdEncargado);
            oCampos.Add(chkDias);

            if (revisarCampos(oCampos) == oCampos.Count)
            {
                ViewState["CurrentTable"] = null;
                testDays();
            }
        }

        private void testDays()
        {
            DateTime fechaInicio = DateTime.Parse(txtFechaInicio_Evt.Text);
            DateTime fechaFinal = DateTime.Parse(txtFechaFinal_Evt.Text);
            TimeSpan horaInicio = TimeSpan.Parse(txtHoraInicio.Text);
            TimeSpan horaFinal = TimeSpan.Parse(txtHoraFinal.Text);

            for (DateTime i = fechaInicio; i <= fechaFinal; i = i.AddDays(1))
            {
                foreach (ListItem item in chkDias.Items)
                {
                    if (item.Selected)
                    {
                        if ((int)i.DayOfWeek == Convert.ToInt32(item.Value))
                        {
                            AddNewRowToGrid(i.Date, horaInicio, horaFinal);

                        }
                    }
                }

            }



        }

        private void AddNewRowToGrid(DateTime fecha, TimeSpan horaInicio, TimeSpan horaFinal)
        {
            LimpiarMensajes();
            int i = 0;
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;

            if (dtCurrentTable != null)
            {
                i = dtCurrentTable.Rows.Count;
                drCurrentRow = dtCurrentTable.NewRow();
                drCurrentRow["RowNumber"] = i + 1;

                dtCurrentTable.Rows.Add(drCurrentRow);
                ViewState["CurrentTable"] = dtCurrentTable;
                dtCurrentTable.Rows[i]["Column2"] = fecha.ToString("yyyy-MM-dd");
                dtCurrentTable.Rows[i]["Column3"] = horaInicio;
                dtCurrentTable.Rows[i]["Column4"] = horaFinal;
                dtCurrentTable.Rows[i]["Column5"] = txtIdEncargado.Text;
                dtCurrentTable.Rows[i]["ControlPC"] = chkControlPC_Evento.Checked;
                grvFechasEvento.DataSource = dtCurrentTable;
                grvFechasEvento.DataBind();

                DropDownList ddl2 = (DropDownList)grvFechasEvento.Rows[i].Cells[1].FindControl("ddlEspacio_grvEvt");
                ddl2.SelectedValue = ddlEspacio.SelectedValue;
                dtCurrentTable.Rows[i]["Column1"] = ddlEspacio.SelectedItem.Text;

                CheckBox chkControl = (CheckBox)grvFechasEvento.Rows[0].Cells[6].FindControl("chkControlPC_grvEspacio");
                chkControl.Checked = chkControlPC_Evento.Checked;
            }
            else
            {
                DataTable dt = new DataTable();
                DataRow dr = null;
                dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                dt.Columns.Add(new DataColumn("Column1", typeof(string)));
                dt.Columns.Add(new DataColumn("Column2", typeof(string)));
                dt.Columns.Add(new DataColumn("Column3", typeof(string)));
                dt.Columns.Add(new DataColumn("Column4", typeof(string)));
                dt.Columns.Add(new DataColumn("Column5", typeof(string)));
                dt.Columns.Add(new DataColumn("ControlPC", typeof(bool)));
                dr = dt.NewRow();
                dr["RowNumber"] = 1;

                dr["Column2"] = fecha.ToString("yyyy-MM-dd");
                dr["Column3"] = horaInicio;
                dr["Column4"] = horaFinal;
                dr["Column5"] = txtIdEncargado.Text;
                dr["ControlPC"] = chkControlPC_Evento.Checked;
                dt.Rows.Add(dr);
                //dr = dt.NewRow();
                //Store the DataTable in ViewState
                ViewState["CurrentTable"] = dt;

                grvFechasEvento.DataSource = dt;
                grvFechasEvento.DataBind();

                DropDownList ddl1 = (DropDownList)grvFechasEvento.Rows[0].Cells[1].FindControl("ddlEspacio_grvEvt");
                llenarComboEspacio(ddl1);
                ddl1.SelectedValue = ddlEspacio.SelectedValue;

                CheckBox chkControl = (CheckBox)grvFechasEvento.Rows[0].Cells[6].FindControl("chkControlPC_grvEspacio");
                chkControl.Checked = chkControlPC_Evento.Checked;

            }
            //Set Previous Data on Postbacks

            SetPreviousData();
        }

        private void AddNewRowToGrid(DateTime fecha, TimeSpan horaInicio, TimeSpan horaFinal, int idTipoId, string idEncargado, string idEspacio, bool ControlPC)
        {
            LimpiarMensajes();
            int i = 0;
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable"];
            DataRow drCurrentRow = null;

            if (dtCurrentTable != null)
            {
                i = dtCurrentTable.Rows.Count;
                drCurrentRow = dtCurrentTable.NewRow();
                drCurrentRow["RowNumber"] = i + 1;

                dtCurrentTable.Rows.Add(drCurrentRow);
                ViewState["CurrentTable"] = dtCurrentTable;
                dtCurrentTable.Rows[i]["Column2"] = fecha.ToString("yyyy-MM-dd");
                dtCurrentTable.Rows[i]["Column3"] = horaInicio;
                dtCurrentTable.Rows[i]["Column4"] = horaFinal;
                dtCurrentTable.Rows[i]["Column5"] = idEncargado;
                dtCurrentTable.Rows[i]["ControlPC"] = ControlPC;
                grvFechasEvento.DataSource = dtCurrentTable;
                grvFechasEvento.DataBind();

                DropDownList ddl2 = (DropDownList)grvFechasEvento.Rows[i].Cells[1].FindControl("ddlEspacio_grvEvt");
                llenarComboEspacio(ddl2);
                ddl2.SelectedValue = idEspacio;
                ddlEspacio.SelectedValue = idEspacio;
                dtCurrentTable.Rows[i]["Column1"] = idEspacio;

            }
            else
            {
                DataTable dt = new DataTable();
                DataRow dr = null;
                dt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
                dt.Columns.Add(new DataColumn("Column1", typeof(string)));
                dt.Columns.Add(new DataColumn("Column2", typeof(string)));
                dt.Columns.Add(new DataColumn("Column3", typeof(string)));
                dt.Columns.Add(new DataColumn("Column4", typeof(string)));
                dt.Columns.Add(new DataColumn("Column5", typeof(string)));
                dt.Columns.Add(new DataColumn("ControlPC", typeof(bool)));
                dr = dt.NewRow();
                dr["RowNumber"] = 1;

                dr["Column2"] = fecha.ToString("yyyy-MM-dd");
                dr["Column3"] = horaInicio;
                dr["Column4"] = horaFinal;
                dr["Column5"] = idEncargado;
                dr["ControlPC"] = ControlPC;
                dt.Rows.Add(dr);
                //dr = dt.NewRow();
                //Store the DataTable in ViewState
                ViewState["CurrentTable"] = dt;

                grvFechasEvento.DataSource = dt;
                grvFechasEvento.DataBind();

                DropDownList ddl1 = (DropDownList)grvFechasEvento.Rows[0].Cells[1].FindControl("ddlEspacio_grvEvt");
                llenarComboEspacio(ddl1);
                ddl1.SelectedValue = idEspacio;
                dt.Rows[i]["Column1"] = idEspacio;

            }
            //Set Previous Data on Postbacks

            SetPreviousData();
        }

        protected void RemoveRow_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LinkButton lb = (LinkButton)sender;
            GridViewRow gvRow = (GridViewRow)lb.NamingContainer;
            int rowID = gvRow.RowIndex;
            if (ViewState["CurrentTable"] != null)
            {

                DataTable dt = (DataTable)ViewState["CurrentTable"];
                if (dt.Rows.Count >= 1)
                {
                    if (gvRow.RowIndex <= dt.Rows.Count - 1)
                    {
                        //Remove the Selected Row data and reset row number  
                        dt.Rows.Remove(dt.Rows[rowID]);
                        ResetRowID(dt);
                    }
                }

                //Store the current data in ViewState for future reference  
                ViewState["CurrentTable"] = dt;

                //Re bind the GridView for the updated data  
                grvFechasEvento.DataSource = dt;
                grvFechasEvento.DataBind();
            }

            //Set Previous Data on Postbacks  
            SetPreviousData();
        }

        private void ResetRowID(DataTable dt)
        {
            int rowNumber = 1;
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    row[0] = rowNumber;
                    rowNumber++;
                }
            }
        }

        protected void txtFechaInicio_Evt_TextChanged(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (!String.IsNullOrEmpty(txtFechaInicio_Evt.Text))
            {
                txtFechaFinal_Evt.Attributes["min"] = Convert.ToDateTime(txtFechaInicio_Evt.Text).ToString("yyyy-MM-dd");
                txtFechaFinal_Evt.Text = Convert.ToDateTime(txtFechaInicio_Evt.Text).ToString("yyyy-MM-dd");
                txtFechaFinal_Evt.Focus();
            }
            else
            {
                txtFechaFinal_Evt.Text = null;
                txtFechaFinal_Evt.Attributes["min"] = null;
            }

        }

        protected void txtHoraInicio_TextChanged(object sender, EventArgs e)
        {
            LimpiarMensajes();
            if (!String.IsNullOrEmpty(txtHoraInicio.Text))
            {
                txtHoraFinal.Attributes["min"] = Convert.ToDateTime(txtHoraInicio.Text).AddMinutes(5).ToString("HH:mm");
                txtHoraFinal.Text = Convert.ToDateTime(txtHoraInicio.Text).AddMinutes(5).ToString("HH:mm");
            }
            else
            {
                txtHoraFinal.Text = null;
                txtHoraFinal.Attributes["min"] = null;
            }
        }

        protected void ddlTipoIdentificacion_SelectedIndexChanged(object sender, EventArgs e)
        {
            LimpiarMensajes();

            cambiarMascara(MaskedEditExtender1, ddlTipoIdentificacion_Evento);

        }

        protected void ddlEvento_Evt_SelectedIndexChanged(object sender, EventArgs e)
        {
            AgregarFechasDataBase();
        }

        protected void ddlPeriodo_Evt_SelectedIndexChanged(object sender, EventArgs e)
        {
            AgregarFechasDataBase();
        }

        /*******************************************************************************************/
        /**********                             Pestaña Persona                           **********/
        /*******************************************************************************************/

        private void llenarGridPersona()
        {
            try
            {
                grvPersonas_persona.DataSource = ProcesosBLL.obtenerPersona();
                grvPersonas_persona.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }
        private void llenarComboPais()
        {
            try
            {
                ddlPais_Persona.DataSource = ProcesosBLL.obtenerPais();
                ddlPais_Persona.DataValueField = "idPais";
                ddlPais_Persona.DataTextField = "nombre";
                ddlPais_Persona.DataBind();
                ddlPais_Persona.SelectedValue = "60";
            }
            catch (Exception)
            {

                throw;
            }
        }
        protected void btnGuardar_Persona_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtId_Persona);
            oCampos.Add(txtNombre_Persona);
            oCampos.Add(ddlEstadoCivil_Persona);
            oCampos.Add(txtFechaNacimiento);
            oCampos.Add(ddlEstadoCivil_Persona);
            oCampos.Add(ddlSexo_Persona);
            oCampos.Add(ddlPais_Persona);
            oCampos.Add(ddlEstado);

            try
            {
                if (revisarCampos(oCampos) == oCampos.Count)
                {
                    mskIdPersona_Persona.ClearMaskOnLostFocus = true;
                    if (!String.IsNullOrEmpty(txtTelefono_Persona.Text) || !String.IsNullOrEmpty(txtWhatsApp_Persona.Text))
                    {
                        txtTelefono_Persona.BorderColor = Color.Empty;
                        txtWhatsApp_Persona.BorderColor = Color.Empty;

                        Persona oPersona = new Persona();
                        oPersona.tipoIdPersona = Convert.ToInt32(ddlTpId_Persona.SelectedValue);
                        oPersona.idPersona = txtId_Persona.Text;
                        oPersona.nombre_Completo = txtNombre_Persona.Text;
                        oPersona.celular = txtWhatsApp_Persona.Text;
                        oPersona.telefono = txtTelefono_Persona.Text;
                        oPersona.email = txtEmail_Persona.Text;
                        oPersona.estadoCivil = ddlEstadoCivil_Persona.SelectedValue;
                        oPersona.fechaNacimiento = txtFechaNacimiento.Text;
                        oPersona.direccion = txtDireccion_Persona.Text;
                        oPersona.sexo = ddlSexo_Persona.SelectedValue;
                        oPersona.pais = Convert.ToInt32(ddlPais_Persona.SelectedValue);
                        oPersona.ContactoEmergencia = txtNombre_Contacto_Persona.Text;
                        oPersona.telContacto = txtTel_Contacto_Persona.Text;

                        ArrayList oDatos = (ArrayList)Session["Usuario"];
                        ProcesosBLL.GuardarPersona(oPersona, oDatos[0].ToString());
                        llenarGridPersona();
                        LimpiarCampos(tabPersona1.Controls);
                        showMessage(ltlMessage, "Datos guardados correctamente", 1);
                    }
                    else
                    {
                        txtTelefono_Persona.BorderColor = Color.Red;
                        txtWhatsApp_Persona.BorderColor = Color.Red;
                    }
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btnCancelar_Persona_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LimpiarCampos(tabPersona1.Controls);
            ddlPais_Persona.SelectedValue = "60";
            ScriptManager.RegisterStartupScript(this, this.GetType(), "tabs", string.Format("changeTab({0});", 2), true);
        }

        protected void btnEliminar_Persona_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                ArrayList oDatos = (ArrayList)Session["Usuario"];

            }
            catch (Exception)
            {

                throw;
            }
        }

        private void leertxt(TextBox txtCedula)
        {
            string rutaAlajuela = Server.MapPath("~/Archivos/Al.txt");
            string rutaHeredia = Server.MapPath("~/Archivos/He.txt");
            string[] partes;
            bool bandera = false;

            try
            {

                string[] linesAlajuela = File.ReadAllLines(rutaAlajuela, Encoding.GetEncoding("iso-8859-1"));

                foreach (string line in linesAlajuela)
                {
                    partes = line.Split(',');
                    if (string.Equals(partes[0], txtCedula.Text))
                    {
                        txtNombre_Persona.Text = partes[5].Substring(0, 1) + partes[5].Substring(1, partes[5].IndexOf(' ')).Trim().ToLower() + " " + partes[5].Substring(partes[5].IndexOf(' ') + 1, 1).ToUpper().Trim() + partes[5].Substring(partes[5].IndexOf(' ') + 2).ToLower().Trim()
                            + " " + partes[6].Trim().Substring(0, 1) + partes[6].Substring(1).Trim().ToLower() + " " + partes[7].Substring(0, 1) + partes[7].Substring(1).Trim().ToLower();

                        switch (partes[2].Trim())
                        {
                            case "1":
                                ddlSexo_Persona.SelectedValue = "male";
                                break;
                            case "2":
                                ddlSexo_Persona.SelectedValue = "female";
                                break;
                            default:
                                break;
                        }

                        bandera = true;
                        break;
                    }
                    else
                    {
                        bandera = false;
                        txtNombre_Persona.Text = "";
                        txtNombre_Persona.Focus();
                    }


                    //DoSomething(line);
                }

            }
            catch (Exception ex)
            {
                txtNombre_Persona.Text = "";
                txtNombre_Persona.Focus();
            }
        }

        protected void txtId_Persona_TextChanged(object sender, EventArgs e)
        {
            leertxt(txtId_Persona);
        }

        protected void ddlTpId_Persona_SelectedIndexChanged(object sender, EventArgs e)
        {
            cambiarMascara(mskIdPersona_Persona, ddlTpId_Persona);
        }

        protected void grvPersonas_persona_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvPersonas_persona.Rows[index];

            try
            {

                switch (e.CommandName)
                {
                    case "Modificar":
                        string idTipoID = grvPersonas_persona.DataKeys[index].Values[0].ToString();
                        string ID = grvPersonas_persona.DataKeys[index].Values[1].ToString();
                        DataTable dt = ProcesosBLL.obtenerPersona();
                        DataRow[] rows = dt.Select("idTipoIdentificacion = " + idTipoID + " and numero_identificacion like '" + ID + "'");

                        ddlTpId_Persona.SelectedValue = idTipoID;
                        txtId_Persona.Text = rows[0]["numero_identificacion"].ToString();
                        txtNombre_Persona.Text = rows[0]["nombre_Completo"].ToString();
                        txtWhatsApp_Persona.Text = rows[0]["celular"].ToString();
                        txtTelefono_Persona.Text = rows[0]["telefono"].ToString();
                        txtEmail_Persona.Text = rows[0]["email"].ToString();
                        ddlEstadoCivil_Persona.SelectedValue = rows[0]["estadoCivil"].ToString();
                        txtFechaNacimiento.Text = Convert.ToDateTime(rows[0]["fecha_Nacimiento"].ToString()).ToString("yyyy-MM-dd"); ;
                        txtDireccion_Persona.Text = rows[0]["direccion"].ToString();
                        ddlSexo_Persona.SelectedValue = rows[0]["sexo"].ToString();
                        ddlPais_Persona.SelectedValue = rows[0]["idPais"].ToString();
                        txtNombre_Contacto_Persona.Text = rows[0]["nombre_Completo_Emergencia"].ToString();
                        txtTel_Contacto_Persona.Text = rows[0]["telefono_Contacto"].ToString();
                        ddlEstado.SelectedValue = rows[0]["estado"].ToString();
                        break;


                    case "EnviarWhatsApp":
                        string celular = rowV.Cells[3].Text;
                        string url = "https://api.whatsapp.com/send?phone=506" + celular;

                        //string url = "Add_Items.aspx?TestID=" + ID;
                        string fullURL = "window.open('" + url + "', '_blank' );";
                        ScriptManager.RegisterStartupScript(this, typeof(string), "OPEN_WINDOW", fullURL, true);
                        //Response.Redirect(url);
                        break;
                    default:
                        break;
                }




            }
            catch (Exception ex)
            {

                throw;
            }
        }
        /*******************************************************************************************/
        /**********                           Pestaña Inscripcion                         **********/
        /*******************************************************************************************/
        protected void btnGuardar_Inscripcion_Click(object sender, EventArgs e)
        {

            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(ddlEvento_Inscrip);
            oCampos.Add(ddlPeriodo_Inscrip);
            try
            {
                if (revisarCampos(oCampos) == oCampos.Count)
                {

                    Matricula oMatricula = new Matricula();
                    oMatricula.idTipoIdentificacion = Convert.ToInt32(ddlTipoId.SelectedValue);
                    oMatricula.idPersona = ddlPersonasInscripcion.SelectedValue.ToString();
                    oMatricula.idEvento = Convert.ToInt32(ddlEvento_Inscrip.SelectedValue);
                    oMatricula.idPeriodo = Convert.ToInt32(ddlPeriodo_Inscrip.SelectedValue);
                    oMatricula.banco = ddlBanco_Inscrip.SelectedValue;
                    if (string.IsNullOrEmpty(txtMonto_Inscrip.Text.Trim()))
                    {
                        oMatricula.monto = 0;
                    }
                    else
                    {
                        oMatricula.monto = Convert.ToDouble(txtMonto_Inscrip.Text);
                    }

                    oMatricula.numComprobante = txtNumComprobante_Inscrip.Text;
                    if (string.IsNullOrEmpty(txtFechaComprobante_Incrip.Text))
                    {
                        oMatricula.fechaComprobante = Convert.ToDateTime("01/01/0001").ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        oMatricula.fechaComprobante = txtFechaComprobante_Incrip.Text;
                    }

                    oMatricula.poliza = txtNumPoliza_Incrip.Text;

                    if (string.IsNullOrEmpty(txtFechaPoliza.Text))
                    {
                        oMatricula.fechaPoliza = Convert.ToDateTime("01/01/0001").ToString("yyyy-MM-dd");
                    }
                    else
                    {
                        oMatricula.fechaPoliza = txtFechaPoliza.Text;
                    }
                    oMatricula.observaciones = txtObservaciones_Inscrip.Text;
                    oMatricula.situacionEspecial = txtSituacion_Inscrip.Text;
                    oMatricula.estado = true;

                    ArrayList oDatos = (ArrayList)Session["Usuario"];
                    ProcesosBLL.GuardarInscripcion(oMatricula, oDatos[0].ToString());
                    showMessage(ltlMessage, ddlPersonasInscripcion.SelectedValue.ToString() + "ha sido agregado correctamente", 1);
                    if (rdbUsoLabSi.Checked)
                    {
                        oMatricula.idEvento = 7;
                        oMatricula.idPeriodo = 11;
                        oMatricula.monto = 0;
                        ProcesosBLL.GuardarInscripcion(oMatricula, oDatos[0].ToString());
                        showMessage(ltlMessage, "Se incluyó en el grupo de Uso de Labotario", 1);
                    }
                    obtenerMatriculados(ddlEvento_Inscrip.SelectedValue, ddlPeriodo_Inscrip.SelectedValue);
                    LimpiarCampos(tabInscripcion1.Controls);
                }


            }
            catch (Exception ex)
            {
                showMessage(ltlMessage, "Error al inscribir a la persona \n" + ex.ToString(), 2);
            }

        }

        protected void btnCancelar_Inscripcion_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LimpiarCampos(tabInscripcion1.Controls);
        }

        private void obtenerMatriculados(string idEventop, string idPeriodop)
        {
            try
            {
                grvInscripcion.DataSource = ProcesosBLL.obtenerMatriculados(Convert.ToInt32(idEventop), Convert.ToInt32(idPeriodop));
                grvInscripcion.DataBind();
            }
            catch (Exception ex)
            {
                showMessage(ltlMessage, ex.ToString(), 2);
            }
        }

        protected void ddlEvento_Inscrip_SelectedIndexChanged(object sender, EventArgs e)
        {
            obtenerMatriculados(ddlEvento_Inscrip.SelectedValue, ddlPeriodo_Inscrip.SelectedValue);
        }

        protected void ddlPeriodo_Inscrip_SelectedIndexChanged(object sender, EventArgs e)
        {
            obtenerMatriculados(ddlEvento_Inscrip.SelectedValue, ddlPeriodo_Inscrip.SelectedValue);
        }

        protected void grvInscripcion_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvInscripcion.Rows[index];

            try
            {
                switch (e.CommandName)
                {
                    case "Modificar":
                        ddlPersonasInscripcion.SelectedValue = grvInscripcion.DataKeys[index].Values[1].ToString();
                        ddlEvento_Inscrip.SelectedValue = grvInscripcion.DataKeys[index].Values[2].ToString();
                        ddlPeriodo_Inscrip.SelectedValue = grvInscripcion.DataKeys[index].Values[3].ToString();
                        ddlBanco_Inscrip.SelectedValue = grvInscripcion.DataKeys[index].Values[4].ToString();
                        txtMonto_Inscrip.Text = grvInscripcion.DataKeys[index].Values[5].ToString();
                        txtNumComprobante_Inscrip.Text = grvInscripcion.DataKeys[index].Values[6].ToString();
                        txtFechaComprobante_Incrip.Text = Convert.ToDateTime(grvInscripcion.DataKeys[index].Values[7].ToString()).ToString("yyyy-MM-dd");
                        txtNumPoliza_Incrip.Text = grvInscripcion.DataKeys[index].Values[8].ToString();
                        txtFechaPoliza.Text = Convert.ToDateTime(grvInscripcion.DataKeys[index].Values[9].ToString()).ToString("yyyy-MM-dd");
                        txtObservaciones_Inscrip.Text = grvInscripcion.DataKeys[index].Values[10].ToString();
                        txtSituacion_Inscrip.Text = grvInscripcion.DataKeys[index].Values[11].ToString();
                        break;

                    case "Imprimir":
                        Session["cedula"] = grvInscripcion.DataKeys[index].Values[1].ToString();
                        Session["idEvento"] = grvInscripcion.DataKeys[index].Values[2].ToString();
                        Session["idPeriodo"] = grvInscripcion.DataKeys[index].Values[3].ToString();
                        string Url = "/HojaMatricula.aspx" + "?idEvento=" + grvInscripcion.DataKeys[index].Values[2].ToString() + "&idPeriodo=" + grvInscripcion.DataKeys[index].Values[3].ToString() + "&identificacion=" + grvInscripcion.DataKeys[index].Values[1].ToString();
                        Response.Redirect(Url);
                        break;

                    case "Eliminar":
                        int idTipoId = Convert.ToInt32(grvInscripcion.DataKeys[index].Values[0].ToString());
                        string identificacion = grvInscripcion.DataKeys[index].Values[1].ToString();
                        int idEvento = Convert.ToInt32(grvInscripcion.DataKeys[index].Values[2].ToString());
                        int idPeriodo = Convert.ToInt32(grvInscripcion.DataKeys[index].Values[3].ToString());

                        int RegistrosBorrados = ProcesosBLL.eliminarInscripcion(idTipoId, identificacion, idEvento, idPeriodo);
                        obtenerMatriculados(idEvento.ToString(), idPeriodo.ToString());
                        showMessage(ltlMessage, RegistrosBorrados + " han sido borrados correctamente", 1);
                        break;
                    default:
                        break;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btnLeerExcel_Click(object sender, EventArgs e)
        {
            String strConnection = "ConnectionString";
            string connectionString = "";
            if (fileUp.HasFile)
            {
                string fileName = Path.GetFileName(fileUp.PostedFile.FileName);
                string fileExtension = Path.GetExtension(fileUp.PostedFile.FileName);
                string fileLocation = Server.MapPath("~/Archivos/" + fileName);
                fileUp.SaveAs(fileLocation);
                if (fileExtension == ".xls")
                {
                    connectionString = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +
                      fileLocation + ";Extended Properties=\"Excel 8.0;HDR=Yes;IMEX=2\"";
                }
                else if (fileExtension == ".xlsx")
                {
                    connectionString = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" +
                      fileLocation + ";Extended Properties=\"Excel 12.0;HDR=Yes;IMEX=2\"";
                }
                OleDbConnection con = new OleDbConnection(connectionString);
                OleDbCommand cmd = new OleDbCommand();
                cmd.CommandType = System.Data.CommandType.Text;
                cmd.Connection = con;
                OleDbDataAdapter dAdapter = new OleDbDataAdapter(cmd);
                DataTable dtExcelRecords = new DataTable();
                con.Open();
                DataTable dtExcelSheetName = con.GetOleDbSchemaTable(OleDbSchemaGuid.Tables, null);
                string getExcelSheetName = dtExcelSheetName.Rows[0]["Table_Name"].ToString();
                cmd.CommandText = "SELECT * FROM [" + getExcelSheetName + "]";
                dAdapter.SelectCommand = cmd;
                dAdapter.Fill(dtExcelRecords);
                LlenarGridEstudianteExcel(dtExcelRecords);
                con.Close();

            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalExcel();", true);
            }



            ////////////////////////////////////////////////////////////////////////////////////////////
            //////////                                  FIN                                   ////////// 
            ////////////////////////////////////////////////////////////////////////////////////////////
        }

        private void LlenarGridEstudianteExcel(DataTable dtExcelRecords)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("TipoID");
            dt.Columns.Add("ID");
            dt.Columns.Add("nombreCompleto");
            dt.Columns.Add("sexo");
            dt.Columns.Add("celular");
            dt.Columns.Add("telefono");
            dt.Columns.Add("email");
            dt.Columns.Add("fechaNacimiento");
            dt.Columns.Add("Pais");

            foreach (DataRow oRow in dtExcelRecords.Rows)
            {
                if (oRow["ID"].ToString().Trim() != "")
                {
                    string tipoID = oRow[0].ToString();
                    string ID = oRow[1].ToString();
                    string nombreCompleto = oRow[2].ToString();
                    string sexo = "";
                    switch (oRow[3].ToString())
                    {
                        case "F":
                            sexo = "Femenino";
                            break;
                        case "M":
                            sexo = "Masculino";
                            break;
                        default:
                            break;
                    }
                    string celular = oRow[4].ToString();
                    string telefono = oRow[5].ToString();
                    string email = oRow[6].ToString();
                    string fechaNacimiento = Convert.ToDateTime(oRow[7].ToString()).ToString("dd/MM/yyyy");
                    int idPais = 60;
                    string pais = "Costa Rica";
                    try
                    {
                        idPais = Convert.ToInt32(ddlPais_Persona.Items.FindByText(oRow[8].ToString()).Value);
                        pais = ddlPais_Persona.Items.FindByText(oRow[8].ToString()).Text;
                    }
                    catch (Exception)
                    {
                        idPais = Convert.ToInt32(ddlPais_Persona.Items.FindByText("Costa Rica").Value);
                        pais = ddlPais_Persona.Items.FindByText("Costa Rica").Text;
                    }

                    String[] row = { tipoID, ID, nombreCompleto, sexo, celular, telefono, email, fechaNacimiento, pais };
                    dt.Rows.Add(row);
                    grvEstudiantesExcel.DataSource = dt;
                    ViewState["dtEstudiantesExcel"] = dt;
                }
            }


            //grvEstudiantesExcel.DataSource = dtExcelRecords;
            grvEstudiantesExcel.DataBind();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModalExcel();", true);
        }


        /*******************************************************************************************/
        /**********                               Modal Excel                             **********/
        /*******************************************************************************************/

        protected void btnGuardar_MdlExcel_Click(object sender, EventArgs e)
        {
            ArrayList oLstPersona = new ArrayList();
            ArrayList oLstMatricula = new ArrayList();

            DataTable dt = ViewState["dtEstudiantesExcel"] as DataTable;
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow oRow in dt.Rows)
                {
                    Persona oPersona = new Persona();
                    switch (oRow["tipoID"].ToString())
                    {
                        case "Cedula":
                            oPersona.tipoIdPersona = 1;
                            break;
                        case "Residencia":
                            oPersona.tipoIdPersona = 2;
                            break;
                        case "Pasaporte":
                            oPersona.tipoIdPersona = 3;
                            break;
                        default:
                            oPersona.tipoIdPersona = 1;
                            break;
                    }

                    oPersona.idPersona = oRow["ID"].ToString();
                    oPersona.nombre_Completo = oRow["nombreCompleto"].ToString();
                    switch (oRow["sexo"].ToString())
                    {
                        case "F":
                            oPersona.sexo = "female";
                            break;
                        case "M":
                            oPersona.sexo = "male";
                            break;
                        default:
                            oPersona.sexo = "female";
                            break;
                    }
                    oPersona.celular = oRow["celular"].ToString();
                    oPersona.telefono = oRow["telefono"].ToString();
                    oPersona.email = oRow["email"].ToString();
                    oPersona.fechaNacimiento = Convert.ToDateTime(oRow["fechaNacimiento"].ToString()).ToString("yyyy/MM/dd");
                    oPersona.pais = Convert.ToInt32(ddlPais_Persona.Items.FindByText(oRow["Pais"].ToString()).Value);
                    oLstPersona.Add(oPersona);
                    Matricula oMatricula = new Matricula();
                    oMatricula.idEvento = Convert.ToInt32(ddlEvento_MdlExcel.SelectedValue);
                    oMatricula.idPeriodo = Convert.ToInt32(ddlPeriodo_MdlExcel.SelectedValue);
                    oMatricula.idTipoIdentificacion = oPersona.tipoIdPersona;
                    oMatricula.idPersona = oPersona.idPersona;
                    oLstMatricula.Add(oMatricula);
                }

                try
                {
                    int registro = ProcesosBLL.guardarExcel(oLstPersona, oLstMatricula, "");
                    showMessage(ltlInscripcion, registro - oLstMatricula.Count + " registros agregados correctamente", 1);
                }
                catch (Exception ex)
                {
                    showMessage(ltlInscripcion, "Error al gurdar la información " + ex.ToString(), 2);
                }

            }
        }

        protected void BtnCancelar_MdlExcel_Click(object sender, EventArgs e)
        {

        }


        /*******************************************************************************************/
        /**********                             Pestaña Periodo                           **********/
        /*******************************************************************************************/

        private void obtenerPeriodo(int estado)
        {
            try
            {
                grvPeriodo.DataSource = ProcesosBLL.obtenerPeriodo(estado);
                grvPeriodo.DataBind();
            }
            catch (Exception)
            {
                showMessage(ltlMessage, "Error a la cargar los datos del periodo", 2);
            }
        }

        protected void btnGuardar_Periodo_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtNombre_Periodo);
            oCampos.Add(ddlEstado_Periodo);
            try
            {
                if (revisarCampos(oCampos) == oCampos.Count)
                {
                    periodo oPeriodo = new periodo();
                    oPeriodo.idPeriodo = Convert.ToInt32(hdfIdPeriodo.Value);
                    oPeriodo.periodo_descripcion = txtNombre_Periodo.Text;
                    oPeriodo.observaciones = txtObservaciones_Periodo.Text;
                    oPeriodo.estado = Convert.ToBoolean(ddlEstado_Periodo.SelectedValue);

                    ArrayList oDatos = (ArrayList)Session["Usuario"];
                    ProcesosBLL.GuardarPeriodo(oPeriodo, oDatos[0].ToString());

                    showMessage(ltlMessage, txtNombre_Periodo.Text + "ha sido agregado correctamente", 1);

                    obtenerPeriodo(1);
                    LimpiarCampos(tabPeriodo1.Controls);
                    hdfIdPeriodo.Value = "0";
                }
                else
                {
                    showMessage(ltlMessage, "Por favor complete los campos antes de continuar", 3);
                }


            }
            catch (Exception)
            {
                showMessage(ltlMessage, "Error al guardar la informacion", 2);
            }
        }

        protected void btnCancelar_Periodo_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LimpiarCampos(tabPeriodo1.Controls);
        }

        protected void btnEliminar_Periodo_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();

            try
            {
                if (!String.Equals(hdfIdPeriodo.Value, "0"))
                {
                    ArrayList oDatos = (ArrayList)Session["Usuario"];
                    ProcesosBLL.EliminarPeriodo(Convert.ToInt32(hdfIdPeriodo.Value), oDatos[0].ToString());
                    showMessage(ltlMessage, txtNombre_Periodo.Text + "ha sido eliminado correctamente", 1);
                    obtenerPeriodo(1);
                    LimpiarCampos(tabPeriodo1.Controls);
                }
                else
                {
                    showMessage(ltlMessage, "Por favor seleccione un periodo antes de continuar", 3);
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void grvPeriodo_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvPeriodo.Rows[index];
            string idPeriodo = grvPeriodo.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar")
                {
                    hdfIdPeriodo.Value = idPeriodo;
                    txtNombre_Periodo.Text = rowV.Cells[1].Text;
                    if (rowV.Cells[2].Text.Equals("&nbsp;"))
                    {
                        txtObservaciones_Periodo.Text = "";
                    }
                    else
                    {
                        txtObservaciones_Periodo.Text = rowV.Cells[2].Text;
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        /*******************************************************************************************/
        /**********                           Pestaña Tipo Evento                         **********/
        /*******************************************************************************************/

        private void obtenerTipoEvento(int estado)
        {
            try
            {
                grvTipoEvento.DataSource = ProcesosBLL.obtenerTipoEvento(estado);
                grvTipoEvento.DataBind();
            }
            catch (Exception)
            {
                showMessage(ltlMessage, "Error a la cargar los Tipos de Eventos", 2);
            }
        }

        protected void btnGuardarTpEvento_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txtNombre_TpEvento);

            if (revisarCampos(oCampos) == oCampos.Count)
            {
                tipo_evento oTpEvento = new tipo_evento();
                oTpEvento.idTipoEvento = Convert.ToInt32(hdfIdTpEvento.Value);
                oTpEvento.tipoEvento_descripcion = txtNombre_TpEvento.Text;
                oTpEvento.observaciones = txtObservaciones_TpEvento.Text;
                oTpEvento.estado = true;
                ArrayList oDatos = (ArrayList)Session["Usuario"];

                try
                {
                    ProcesosBLL.GuardarTipoEvento(oTpEvento, oDatos[0].ToString());
                    LimpiarCampos(tabTipoEvento1.Controls);
                    obtenerTipoEvento(1);
                    showMessage(ltlMessage, txtNombre_TpEvento.Text + "ha sido agregado correctamente", 1);
                }
                catch (Exception)
                {
                    showMessage(ltlMessage, "Error al guardar la informacion", 2);
                }
            }
        }

        protected void btnCancelarTpEvento_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LimpiarCampos(tabTipoEvento1.Controls);
            obtenerTipoEvento(1);
        }

        protected void btnEliminarTpEvento_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            try
            {
                if (!String.Equals(hdfIdTpEvento.Value, "0"))
                {
                    ArrayList oDatos = (ArrayList)Session["Usuario"];
                    ProcesosBLL.EliminarTipoEvento(Convert.ToInt32(hdfIdTpEvento.Value), oDatos[0].ToString());
                    obtenerTipoEvento(1);
                    LimpiarCampos(tabTipoEvento1.Controls);
                    showMessage(ltlMessage, txtNombre_TpEvento.Text + "ha sido eliminado correctamente", 1);
                }
                else
                {
                    showMessage(ltlMessage, "Por favor seleccione un periodo antes de continuar", 3);
                }
            }
            catch (Exception)
            {
                showMessage(ltlMessage, "Error al eliminar la informacion", 2);
            }
        }

        protected void grvTipoEvento_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvTipoEvento.Rows[index];
            string idTpEvento = grvTipoEvento.DataKeys[index].Value.ToString();

            try
            {
                if (e.CommandName == "Modificar")
                {
                    hdfIdTpEvento.Value = idTpEvento;
                    txtNombre_TpEvento.Text = rowV.Cells[1].Text;
                    if (rowV.Cells[2].Text.Equals("&nbsp;"))
                    {
                        txtObservaciones_TpEvento.Text = "";
                    }
                    else
                    {
                        txtObservaciones_TpEvento.Text = rowV.Cells[2].Text;
                    }

                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        /*******************************************************************************************/
        /**********                         Pestaña Asistencia                            **********/
        /*******************************************************************************************/

        private void ObtenerAsistencia(int idEvento, int idPeriodo, DateTime fecha)
        {
            try
            {
                grvAsistencia.DataSource = ProcesosBLL.obtenerAsistencia(idEvento, idPeriodo, fecha);
                grvAsistencia.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void txtIdPersona_Asistencia_TextChanged(object sender, EventArgs e)
        {
            int tipoID, idEvento, idPeriodo;
            string ID;

            tipoID = Convert.ToInt32(ddlTipoIdentificacion_Asistencia.SelectedValue);
            ID = txtIdPersona_Asistencia.Text;
            idEvento = Convert.ToInt32(ddlEvento_Asistencia.SelectedValue);
            idPeriodo = Convert.ToInt32(ddlPeriodo_Asistencia.SelectedValue);
            DataTable dt = ProcesosBLL.obtenerMatriculados(idEvento, idPeriodo, tipoID, ID);

            if (dt.Rows.Count != 0)
            {
                txtNombrePersona_Asistencia.Text = dt.Rows[0]["nombre_Completo"].ToString();
                txtHoraIngreso_Asistencia.Focus();
            }
            else
            {
                txtNombrePersona_Asistencia.Text = "";
                txtIdPersona_Asistencia.Focus();

            }

        }

        protected void ddlTipoIdentificacion_Asistencia_SelectedIndexChanged(object sender, EventArgs e)
        {
            cambiarMascara(mskIdPersona_Asistencia, ddlTipoIdentificacion_Asistencia);
        }

        protected void btnGuardar_Asitencia_Click(object sender, EventArgs e)
        {
            ArrayList campos = new ArrayList();
            campos.Add(ddlEvento_Asistencia);
            campos.Add(ddlPeriodo_Asistencia);
            campos.Add(ddlFecha_Asistencia);
            campos.Add(ddlTipoIdentificacion_Asistencia);
            campos.Add(txtIdPersona_Asistencia);
            campos.Add(txtHoraIngreso_Asistencia);
            campos.Add(txtHoraSalida_Asistencia);

            if (revisarCampos(campos) == campos.Count)
            {
                try
                {
                    int idEvento, idPeriodo, idTipoID;
                    String fecha, ID, horaIngreso, horaSalida;

                    idEvento = Convert.ToInt32(ddlEvento_Asistencia.SelectedValue);
                    idPeriodo = Convert.ToInt32(ddlPeriodo_Asistencia.SelectedValue);
                    idTipoID = Convert.ToInt32(ddlTipoIdentificacion_Asistencia.SelectedValue);
                    fecha = ddlFecha_Asistencia.SelectedValue;
                    ID = txtIdPersona_Asistencia.Text;
                    horaIngreso = txtHoraIngreso_Asistencia.Text;
                    horaSalida = txtHoraSalida_Asistencia.Text;

                    Asistencia oAsistencia = new Asistencia();
                    oAsistencia.idEvento = idEvento;
                    oAsistencia.idPeriodo = idPeriodo;
                    oAsistencia.idTipoID = idTipoID;
                    oAsistencia.fecha = Convert.ToDateTime(fecha);
                    oAsistencia.ID = ID;
                    oAsistencia.horaIngreso = Convert.ToDateTime(horaIngreso).ToString("HH:mm");
                    oAsistencia.horaSalida = Convert.ToDateTime(horaSalida).ToString("HH:mm");
                    oAsistencia.numPC = txtNumPC.Text;

                    ProcesosBLL.GuardarAsistencia(oAsistencia);
                    ObtenerAsistencia(idEvento, idPeriodo, Convert.ToDateTime(ddlFecha_Asistencia.SelectedValue));
                    LimpiarCampos(tabAsistencia1.Controls);
                }
                catch (Exception)
                {

                    throw;
                }
            }
        }

        protected void btnCancelar_Asistencia_Click(object sender, EventArgs e)
        {
            LimpiarCampos(tabAsistencia1.Controls);
        }

        protected void btnEliminar_Asistencia_Click(object sender, EventArgs e)
        {

        }

        protected void ddlEvento_Asistencia_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idEvento = 0;
            try
            {
                idEvento = Convert.ToInt32(ddlEvento_Asistencia.SelectedValue);
            }
            catch (Exception)
            {
                idEvento = 0;
            }

            int idPeriodo = 0;
            try
            {
                idPeriodo = Convert.ToInt32(ddlPeriodo_Asistencia.SelectedValue);
            }
            catch (Exception)
            {
                idPeriodo = 0;
            }
            llenarComboFechaAsistencias(idEvento, idPeriodo);
            //ObtenerAsistencia(idEvento, idPeriodo, Convert.ToDateTime(ddlFecha_Asistencia.SelectedValue));

            ddlFecha_Asistencia.DataSource = ProcesosBLL.obtenerEspacioEvento(idEvento, idPeriodo);
            ddlFecha_Asistencia.DataTextField = "Column2";
            ddlFecha_Asistencia.DataValueField = "Column2";
            ddlFecha_Asistencia.DataTextFormatString = "{0:dd/MM/yyyy}";
            ddlFecha_Asistencia.DataBind();

            ddlPeriodo_Asistencia.DataSource = ProcesosBLL.obtenerEspacioEvento(idEvento);
            ddlPeriodo_Asistencia.DataTextField = "periodo_descripcion";
            ddlPeriodo_Asistencia.DataValueField = "idPeriodo";
            ddlPeriodo_Asistencia.DataBind();
        }

        protected void ddlPeriodo_Asistencia_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idEvento = Convert.ToInt32(ddlEvento_Asistencia.SelectedValue);
            int idPeriodo = Convert.ToInt32(ddlPeriodo_Asistencia.SelectedValue);
            llenarComboFechaAsistencias(idEvento, idPeriodo);
            //ObtenerAsistencia(idEvento, idPeriodo, Convert.ToDateTime(ddlFecha_Asistencia.SelectedValue));

            ddlFecha_Asistencia.DataSource = ProcesosBLL.obtenerEspacioEvento(idEvento, idPeriodo);
            ddlFecha_Asistencia.DataTextField = "Column2";
            ddlFecha_Asistencia.DataValueField = "Column2";
            ddlFecha_Asistencia.DataTextFormatString = "{0:dd/MM/yyyy}";
            ddlFecha_Asistencia.DataBind();
        }

        protected void ddlFecha_Asistencia_SelectedIndexChanged(object sender, EventArgs e)
        {
            int idEvento = Convert.ToInt32(ddlEvento_Asistencia.SelectedValue);
            int idPeriodo = Convert.ToInt32(ddlPeriodo_Asistencia.SelectedValue);
            ObtenerAsistencia(idEvento, idPeriodo, Convert.ToDateTime(ddlFecha_Asistencia.SelectedValue));
        }

        protected void grvAsistencia_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvAsistencia.Rows[index];
            string idTipoIdenficacion = grvAsistencia.DataKeys[index].Values[0].ToString();
            string ID = grvAsistencia.DataKeys[index].Values[1].ToString();
            string idEvento = grvAsistencia.DataKeys[index].Values[2].ToString();
            string idPeriodo = grvAsistencia.DataKeys[index].Values[3].ToString();
            string fecha = grvAsistencia.DataKeys[index].Values[4].ToString();

            try
            {
                switch (e.CommandName)
                {
                    case "Modificar":
                        ddlEvento_Asistencia.SelectedValue = idEvento;
                        ddlPeriodo_Asistencia.SelectedValue = idPeriodo;
                        ddlFecha_Asistencia.SelectedValue = fecha;
                        ddlTipoIdentificacion_Asistencia.SelectedValue = idTipoIdenficacion;
                        txtIdPersona_Asistencia.Text = ID;
                        txtNombrePersona_Asistencia.Text = grvAsistencia.DataKeys[index].Values[5].ToString();
                        txtHoraIngreso_Asistencia.Text = rowV.Cells[3].Text;
                        txtHoraSalida_Asistencia.Text = rowV.Cells[4].Text;
                        break;

                    case "Eliminar":
                        int idAsistencia = Convert.ToInt32(grvAsistencia.DataKeys[index].Values[6].ToString());
                        ProcesosBLL.EliminarAsistencia(idAsistencia);
                        ObtenerAsistencia(Convert.ToInt32(idEvento), Convert.ToInt32(idPeriodo), Convert.ToDateTime(ddlFecha_Asistencia.SelectedValue));
                        break;
                    default:
                        break;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void llenarComboFechaAsistencias(int idEvento, int idPeriodo)
        {
            ddlFecha_Asistencia.DataSource = ProcesosBLL.obtenerEspacioEvento(idEvento, idPeriodo);
            ddlFecha_Asistencia.DataTextField = "Column2";
            ddlFecha_Asistencia.DataValueField = "Column2";
            ddlFecha_Asistencia.DataTextFormatString = "{0:dd/MM/yyyy}";
            ddlFecha_Asistencia.DataBind();
            if (ddlFecha_Asistencia.SelectedIndex >= 0)
            {
                ObtenerAsistencia(idEvento, idPeriodo, Convert.ToDateTime(ddlFecha_Asistencia.SelectedValue));
            }
        }
        /*******************************************************************************************/
        /**********                               Modal Evento                            **********/
        /*******************************************************************************************/
        private void obtenerEvento(int estado)
        {
            try
            {
                grvEvento.DataSource = ProcesosBLL.obtenerEvento(estado);
                grvEvento.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void llenarComboInstitucion()
        {
            try
            {
                ddlInstitucion_MdlEvento.DataSource = MantenimientoBLL.getInstitucion();
                ddlInstitucion_MdlEvento.DataTextField = "nombre_institucion";
                ddlInstitucion_MdlEvento.DataValueField = "idInstitucion";
                ddlInstitucion_MdlEvento.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btn_MdEvento_Guardar_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            ArrayList oCampos = new ArrayList();
            oCampos.Add(txt_MdEvento_NomEvento);
            oCampos.Add(ddl_MdlEvento_TipoEvento);

            try
            {
                if (revisarCampos(oCampos) == oCampos.Count)
                {
                    evento oEvento = new evento();
                    oEvento.idEvento = Convert.ToInt32(hdf_Md_IdEvento.Value);
                    oEvento.nombre_Evento = txt_MdEvento_NomEvento.Text;
                    oEvento.idTipoEvento = Convert.ToInt32(ddl_MdlEvento_TipoEvento.SelectedValue);
                    oEvento.estado = true;
                    oEvento.idInstitucion = Convert.ToInt32(ddlInstitucion_MdlEvento.SelectedValue);
                    oEvento.observaciones = txtObservaciones_MdlEvento.Text;
                    ArrayList oDatos = (ArrayList)Session["Usuario"];

                    ProcesosBLL.GuardarEvento(oEvento, oDatos[0].ToString());
                    RefrescarCampos();
                    showMessage(ltlMessage, txt_MdEvento_NomEvento.Text + " ha sido agregado correctamente", 1);
                    LimpiarCampos(modalEvento.Controls);
                    hdf_Md_IdEvento.Value = "0";

                }
            }
            catch (Exception)
            {
                showMessage(ltlMessage, txt_MdEvento_NomEvento.Text + "no se ha sido posible guardar el evento", 2);
            }
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void btn_MdEvento_Cancelar_Click(object sender, EventArgs e)
        {
            LimpiarMensajes();
            LimpiarCampos(modalEvento.Controls);
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);
        }

        protected void grvEvento_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            LimpiarMensajes();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openModal();", true);

            int index = Convert.ToInt32(e.CommandArgument);
            GridViewRow rowV = grvEvento.Rows[index];
            string idEvento = grvEvento.DataKeys[index].Values[0].ToString();

            try
            {
                if (e.CommandName == "Modificar")
                {
                    hdf_Md_IdEvento.Value = idEvento;
                    txt_MdEvento_NomEvento.Text = rowV.Cells[1].Text;
                    ddl_MdlEvento_TipoEvento.SelectedValue = grvEvento.DataKeys[index].Values[1].ToString();
                    ddlInstitucion_MdlEvento.SelectedValue = grvEvento.DataKeys[index].Values[2].ToString();
                    txtObservaciones_MdlEvento.Text = rowV.Cells[4].Text;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        /*******************************************************************************************/
        /**********                            Funciones Comunes                          **********/
        /*******************************************************************************************/

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
                    else
                    {
                        if (ctrl is CheckBoxList)
                        {
                            int count = 0;
                            CheckBoxList chk = (CheckBoxList)ctrl;
                            foreach (ListItem item in chk.Items)
                            {
                                if (item.Selected)
                                {
                                    count++;
                                }
                            }

                            if (count != 0)
                            {
                                chk.BackColor = Color.LightGreen;
                                camposLlenos++;
                            }
                            else
                            {
                                chk.BackColor = Color.LightPink;
                            }
                        }
                    }

                }
            }

            return camposLlenos;
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

        private void llenarComboPeriodo(DropDownList ddlPeriodo, int estado)
        {
            try
            {
                ddlPeriodo.DataSource = ProcesosBLL.obtenerPeriodo(estado);
                ddlPeriodo.DataValueField = "idPeriodo";
                ddlPeriodo.DataTextField = "periodo_descripcion";
                ddlPeriodo.DataBind();
            }
            catch (Exception)
            {
                showMessage(ltlMessage, "Error a la cargar la Informacion de Periodo", 2);
            }
        }

        private void llenarComboTipoEvento(DropDownList ddlTipoEvento, int estado)
        {
            try
            {
                ddlTipoEvento.DataSource = ProcesosBLL.obtenerTipoEvento(estado);
                ddlTipoEvento.DataValueField = "idTipoEvento";
                ddlTipoEvento.DataTextField = "tipoEvento_descripcion";
                ddlTipoEvento.DataBind();
            }
            catch (Exception)
            {
                showMessage(ltlMessage, "Error al llenar los combos de Tipos de Eventos", 2);
            }
        }

        private void llenarComboEvento(DropDownList ddlEvento, int estado)
        {
            try
            {
                ddlEvento.DataSource = ProcesosBLL.obtenerEvento(estado);
                ddlEvento.DataValueField = "idEvento";
                ddlEvento.DataTextField = "nombre_Evento";
                ddlEvento.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void llenarComboEspacio(DropDownList ddlEspaciop)
        {
            try
            {
                ddlEspaciop.DataSource = MantenimientoBLL.getEspacioDDL();
                ddlEspaciop.DataValueField = "idEspacio";
                ddlEspaciop.DataTextField = "Espacio";
                ddlEspaciop.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void llenarComboTipoIdentificacion(DropDownList ddlTipoIdentificacionp, int estado)
        {
            try
            {
                ddlTipoIdentificacionp.DataSource = ProcesosBLL.obtenerTipoIdentificacion(estado);
                ddlTipoIdentificacionp.DataValueField = "idTipoIdentificacion";
                ddlTipoIdentificacionp.DataTextField = "descripcion";
                ddlTipoIdentificacionp.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void RefrescarCampos()
        {
            llenarComboPeriodo(ddlPeriodo_Evt, 1);
            llenarComboTipoEvento(ddl_MdlEvento_TipoEvento, 1);
            llenarComboEvento(ddlEvento_Evt, 1);
            llenarComboPeriodo(ddlPeriodo_Inscrip, 1);
            llenarComboEvento(ddlEvento_Inscrip, 1);
            obtenerEvento(1);
            obtenerPeriodo(1);
            obtenerTipoEvento(1);
        }

        private void LimpiarMensajes()
        {
            ltlMessage.Text = "";
            ltlMsg_Eventos.Text = "";
        }

        private void cambiarMascara(AjaxControlToolkit.MaskedEditExtender msk, DropDownList ddlTipoid)
        {
            try
            {
                switch (ddlTipoid.SelectedValue)
                {
                    case "1":
                        msk.Mask = "9-9999-9999";
                        break;

                    case "2":
                        msk.Mask = "999999999999";
                        break;

                    case "3":
                        msk.Mask = "?????????";
                        break;
                    default:
                        break;
                }
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void grvPersonas_persona_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grvPersonas_persona.PageIndex = e.NewPageIndex;
            llenarGridPersona();
        }

        protected void ddlPersonasInscripcion_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtNumPoliza_Incrip.Text = "";
            txtFechaPoliza.Text = "";
            //Obtener ultimo registro de inscripción para extrer póliza
            List<Matricula> oListaMatriculaAnterior = new List<Matricula>();
            Matricula oMatricula = new Matricula();
            DataSet ds = ProcesosBLL.obtenerUltimaMatricula(Convert.ToInt32(ddlTipoId.SelectedValue), ddlPersonasInscripcion.SelectedValue.ToString());
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                oListaMatriculaAnterior.Add(new Matricula { idPersona = Convert.ToString(dr["IdPersona"]), poliza = Convert.ToString(dr["poliza"]), fechaPoliza = Convert.ToString(dr["fechaPoliza"]) });
            }
            if (ds.Tables[0].Rows.Count > 0)
            {
                oMatricula = oListaMatriculaAnterior.Find(x => x.idPersona == ddlPersonasInscripcion.SelectedValue);
                txtNumPoliza_Incrip.Text = oMatricula.poliza;
                txtFechaPoliza.Text = Convert.ToDateTime(oMatricula.fechaPoliza).AddYears(1).ToString("yyyy-MM-dd");
            }
        }
    }

}