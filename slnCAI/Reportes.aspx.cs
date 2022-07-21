using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BLL;
using System.Text;
using System.Web.UI.DataVisualization.Charting;
using System.Collections;
using System.IO;
using System.ComponentModel;
using System.Globalization;
using System.Web.Services;
using System.Web.Script.Services;
using QRCoder;
using System.Drawing.Imaging;

namespace slnCAI
{
    public partial class Reportes : System.Web.UI.Page
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
            ltlMessage.Text = "";
            ltlMessage.Visible = false;
        }
        private void crearTabs(string idRol)
        {
            StringBuilder oTabs = new StringBuilder();

            try
            {
                DataTable dt = SeguridadBLL.getMenu(Convert.ToInt32(idRol), "Reporte");
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
                            case "tabListaMatricula1":
                                llenarComboPeriodo(ddlPeriodo_lstMatricula, 1);
                                llenarComboEvento(lstEvento_lstMatricula, 1);
                                break;
                            case "tabEstadistica1":
                                EstadisticaUsoespacios();
                                break;
                            case "tabAsistencia1":
                                break;

                            case "tabInventario1":
                                break;

                            case "tabEventos1":
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
                    ReportesPage.Visible = false;
                }

            }
            catch (Exception)
            {
                string tab = GetGlobalResourceObject("Mensajes.language", "consultarError").ToString();
                string message = "";
                showMessage(ltlMessage, tab + message, 2);

            }
        }

        /*******************************************************************************************/
        /**********                            Tab Lista Matricula                        **********/
        /*******************************************************************************************/

        protected void btnCrearLista_lstMatricula_Click(object sender, EventArgs e)
        {
            GenerarBoletaAsistencia();
        }

        protected void btnCrearQR_listaMatricula_Click(object sender, EventArgs e)
        {
            GenerarQR();
        }

        private void GenerarBoletaAsistencia()
        {
            StringBuilder table = new StringBuilder();
            StringBuilder encabezadoTable = new StringBuilder();
            int count = 0;

            int idPeriodo = Convert.ToInt32(ddlPeriodo_lstMatricula.SelectedValue);
            ltlContenido_lstMatricula.Text = "";

            foreach (ListItem item in lstEvento_lstMatricula.Items)
            {
                if (item.Selected)
                {
                    table = new StringBuilder();
                    encabezadoTable = new StringBuilder();

                    encabezadoTable.Append("<table style='width: 100%; border: 1px solid black !important; border-collapse: collapse !important; page-break-after: always;'>");
                    encabezadoTable.Append("<tr style='height: 30px; border: 1px solid black; background-color: #002f6b !important; color: white !important; text-align: center; font-size: 12px; font-family: 'Century Gothic'; font-weight: bold;'>");
                    encabezadoTable.Append("<th style='background-color: #002f6b !important; width: 50px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Equipo");
                    encabezadoTable.Append("</th>");
                    encabezadoTable.Append("<th style='width: 90px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Nº Cédula");
                    encabezadoTable.Append("</th>");
                    encabezadoTable.Append("<th style='width: 250px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Nombre Completo");
                    encabezadoTable.Append("</th>");
                    encabezadoTable.Append("<th style='width: 100px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Nº Teléfono");
                    encabezadoTable.Append("</th>");
                    encabezadoTable.Append("<th style='width: 250px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Firma y Hora de Entrada");
                    encabezadoTable.Append("</th>");
                    encabezadoTable.Append("<th style='width: 250px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Firma y Hora de Salida");
                    encabezadoTable.Append("</th>");
                    encabezadoTable.Append("</tr>");



                    int idEvento = Convert.ToInt32(item.Value);
                    DataTable dtMatriculados = ReporteBLL.obtenerPersonasIncritas(idEvento, idPeriodo);

                    foreach (DataRow row in dtMatriculados.Rows)
                    {
                        if (count % 2 == 0)
                        {
                            table.Append("<tr style='height:30px;  text-align:center; border: 1px solid black !important;'>");
                            table.Append("<td style='border: 1px solid black !important;'>");
                            //table.Append(row["NumPc"].ToString());
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(row["IdPersona"].ToString());
                            table.Append("</td><td style='text-align:left;padding-left:2px; border: 1px solid black !important;'>");
                            table.Append(row["nombre_Completo"].ToString());
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(row["celular"].ToString());
                            table.Append("</td><td style='border: 1px solid black !important;'></td>");
                            table.Append("<td style='border: 1px solid black !important;'></td>");
                            table.Append("</tr>");


                        }
                        else
                        {
                            table.Append("<tr style='height:30px;  text-align:center; background-color:#d1e2ff !important; border: 1px solid black !important;'>");
                            table.Append("<td style='border: 1px solid black !important;'>");
                            //table.Append(row["NumPc"].ToString());
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(row["IdPersona"].ToString());
                            table.Append("</td><td style='text-align:left;padding-left:2px; border: 1px solid black !important;'>");
                            table.Append(row["nombre_Completo"].ToString());
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(row["celular"].ToString());
                            table.Append("</td><td style='border: 1px solid black !important;'></td>");
                            table.Append("<td style='border: 1px solid black !important;'></td>");
                            table.Append("</tr>");
                        }
                        count++;
                    }
                    StringBuilder pie = new StringBuilder();
                    pie.Append("<tr><td colspan='6'><span style='font-weight:bold;'>Fecha:");
                    pie.Append(DateTime.Now.ToString("dd/MM/yyyy"));
                    pie.Append("</span><br /><span style='font-weight:bold;'>Observaciones:");
                    pie.Append(item.Text);
                    pie.Append("</span></td></tr></table>");

                    string espacio = "BITÁCORA DE ASISTENCIA";
                    foreach (DataRow oEspacio in ReporteBLL.obtenerEspacioEvento(idEvento, idPeriodo, DateTime.Now.ToString("yyyy-MM-dd")).Rows)
                    {
                        espacio = "BITÁCORA " + oEspacio["Espacio"].ToString();
                    }

                    ltlContenido_lstMatricula.Text += "<br/>" + EncabezadoUTN("Centro de Acceso a la Información - Costa Rica", "Sede Central") + EncabezadaTipo("CENTRO DE ACCESO A LA INFORMACIÓN", espacio.ToUpper()) + encabezadoTable.ToString() + table.ToString() + pie.ToString();

                }

            }



        }

        private void GenerarQR()
        {
            List<System.Web.UI.WebControls.Image> lstImage = new List<System.Web.UI.WebControls.Image>();

            System.Web.UI.WebControls.Image img = new System.Web.UI.WebControls.Image();
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            ArrayList lstImagenes = new ArrayList();

            int idPeriodo = Convert.ToInt32(ddlPeriodo_lstMatricula.SelectedValue);
            ltlContenido_lstMatricula.Text = "";

            StringBuilder sbImagenes = new StringBuilder();

            foreach (ListItem item in lstEvento_lstMatricula.Items)
            {
                if (item.Selected)
                {
                    int j = 0;
                    sbImagenes.Append("<table style='width:100%;border: 1px solid black !important; border-collapse: collapse !important;'>");
                    sbImagenes.Append("<tr style='height:30px;border: 1px solid black !important; background-color: #002f6b !important; color: white !important;'><td colspan=5 style='text-align:center;font-weight:bold;color: white !important;'>");
                    sbImagenes.Append(ddlPeriodo_lstMatricula.SelectedItem.Text + " - " + item.Text);
                    sbImagenes.Append("</td></tr>");

                    int idEvento = Convert.ToInt32(item.Value);
                    DataTable dtMatriculados = ReporteBLL.obtenerPersonasIncritas(idEvento, idPeriodo);
                    lstImagenes = new ArrayList();
                    sbImagenes.Append("<tr>");

                    foreach (DataRow row in dtMatriculados.Rows)
                    {
                        QRCodeData qrCodeData = qrGenerator.CreateQrCode(row["idTipoId"].ToString() + ";" + row["IdPersona"].ToString() + ";" + idEvento + ";" + idPeriodo, QRCodeGenerator.ECCLevel.Q);
                        QRCode qrCode = new QRCode(qrCodeData);

                        Bitmap qrCodeImage = qrCode.GetGraphic(30);

                        using (MemoryStream ms = new MemoryStream())
                        {
                            qrCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                            byte[] byteImage = ms.ToArray();
                            if (j == 5)
                            {
                                sbImagenes.Append("</tr>");
                                sbImagenes.Append("<tr style='border: 1px solid black !important;'>");
                                j = 0;
                            }
                            j++;
                            sbImagenes.Append("<td style='text-align:center;border: 1px solid black !important;'>");
                            sbImagenes.Append("<div style='position: relative;text-align: center;'>");
                            sbImagenes.Append("<img style='width:100%;'  class='img-resposive' src='" + "data:image/png;base64," + Convert.ToBase64String(byteImage) + "'>"); //Imagen
                            sbImagenes.Append("<div style='font-size: 12px;color: #fff!important; -webkit-text-stroke: 0px #000; position: absolute;top: 92%;left: 50%;transform: translate(-50%, -50%);mix-blend-mode: difference!important; font-weight: bolder!important; padding: 5px!important; border-radius: 15px !important; '>");
                            sbImagenes.Append(row["IdPersona"].ToString());
                            sbImagenes.Append("</div></div></td>");
                        }
                    }
                    sbImagenes.Append("</tr></table></br>");
                    ltlContenido_lstMatricula.Text = sbImagenes.ToString();
                }
            }

        }

        private string GenerarTitulo(string nombreCompletop, string idPersonap, string Cursop)
        {
            StringBuilder sbTitulo = new StringBuilder();
            string nombre, id, Curso, nota, duracion;
            string FechaInicio = "", fechaFinal = "";
            nombre = nombreCompletop;
            id = idPersonap;
            Curso = Cursop;
            nota = "10";
            duracion = "40";


            if (!string.IsNullOrEmpty(txtFechaInicio.Text))
            {
                FechaInicio = Convert.ToDateTime(txtFechaInicio.Text).ToString("dd MMMM");
            }

            if (!string.IsNullOrEmpty(txtFechaInicio.Text))
            {
                fechaFinal = Convert.ToDateTime(txtFechaFinal.Text).ToString("dd MMMM Del yyyy");
            }
            
            

            sbTitulo.Append("<div style='page-break-before: always;text-align: center;vertical-align:middle; height:100%; margin-top: 60mm; margin-bottom:60mm;'>");
            sbTitulo.Append("<p style='font-size: 26pt;font-family: Century Gothic;font-weight: bold;'>");
            sbTitulo.Append(nombre);
            sbTitulo.Append("</p>");
            sbTitulo.Append("<p style='font-weight: bold;font-size: 16pt;font-family: Century Gothic;'>Identificación: ");
            sbTitulo.Append(id);
            sbTitulo.Append("</p>");
            sbTitulo.Append("<p style='font-size: 12pt;font-family: Century Gothic;'>");
            sbTitulo.Append("Que ha cumplido satisfactoriamente con los requisitos académicos vigentes en la </br> Institución y se le otorga el certificado de ASISTENCIA AL CURSO");
            sbTitulo.Append("</p>");
            sbTitulo.Append("</br>");
            sbTitulo.Append("<p style='font-weight: bold;font-size: 16pt;font-family: Century Gothic;'>");
            sbTitulo.Append(Curso.ToUpper());
            sbTitulo.Append("</p>");
            sbTitulo.Append("</br><p>REALIZADO DEL ");
            sbTitulo.Append(FechaInicio.ToUpper());
            sbTitulo.Append(" AL ");
            sbTitulo.Append(fechaFinal.ToUpper());
            sbTitulo.Append("</p>");
            sbTitulo.Append("<p style='font-size: 12pt;font-family: Century Gothic;'>NOTA: <b>");
            sbTitulo.Append(nota);
            sbTitulo.Append("</b></p>");
            sbTitulo.Append("<p style='font-size: 12pt;font-family: Century Gothic;'>DURACIÓN: <b>");
            sbTitulo.Append(duracion);
            sbTitulo.Append("</b> Horas</p>");
            sbTitulo.Append("</div>");

            return sbTitulo.ToString();
            
        }

        /*******************************************************************************************/
        /**********                              Tab Estadistica                          **********/
        /*******************************************************************************************/

        private void EstadisticaUsoespacios()
        {
            StringBuilder sbUsoMensual = new StringBuilder();
            try
            {
                string idMes = ddlMes_Estadistica.SelectedValue;
                string anno = ddlAnno_Estadistica.SelectedValue;

                
                foreach (DataRow oRowEspacio in ReporteBLL.obtenerEspacioxEvento(idMes, anno).Rows)
                {
                    DataTable dtEventoEspacio = ReporteBLL.getEventoxEspacio(idMes, anno, oRowEspacio["idEspacio"].ToString());

                    if (dtEventoEspacio.Rows.Count != 0)
                    {
                        sbUsoMensual.Append("<table style='width: 100%; border: 0px solid black !important; border-collapse: collapse !important;'>"); //Empieza la tabla
                        sbUsoMensual.Append("<tr style='height:30px;  text-align:center; border: 1px solid black !important;'>"); //Empieza Fila de Espacio
                        sbUsoMensual.Append("<td style='border: 1px solid black !important;background-color: #002f6b !important; color:#fff !important;' colspan='100%' >"); //Empieza Columna
                        sbUsoMensual.Append("<h2 style='color:#fff !important;'>" + oRowEspacio["espacio"].ToString() + "</h2>"); //Obtiene el nombre del espacio
                        sbUsoMensual.Append("</td>"); //Cierra Columna de Espacio
                        sbUsoMensual.Append("</tr>"); //Cierra fila de Espacio
                        foreach (DataRow oRowEvento in dtEventoEspacio.Rows)
                        {
                            DataTable dtUsoMensual = ReporteBLL.getUsoMensualFechas(idMes, anno, oRowEspacio["idEspacio"].ToString(), oRowEvento["idEvento"].ToString());

                            if (dtUsoMensual.Rows.Count != 0)
                            {
                                sbUsoMensual.Append("<tr style='height:30px;  text-align:center; border: 1px solid black !important;'>"); //Empieza Fila de Evento
                                sbUsoMensual.Append("<td style='border: 1px solid black !important;' colspan='100%' >"); //Empieza Columna

                                sbUsoMensual.Append("<h4>" + oRowEvento["nombre_Evento"].ToString() + "</h4>"); //Obtiene el nombre del Evento
                                sbUsoMensual.Append("</td>"); //Cierra Columna
                                sbUsoMensual.Append("</tr>"); //Cierra fila de Evento

                                sbUsoMensual.Append("<tr style='height:30px;  text-align:center; border: 1px solid black !important;'>"); //Empieza Fila de Uso Mensual

                                foreach (DataRow oRowUso in dtUsoMensual.Rows)
                                {

                                    sbUsoMensual.Append("<td style='border: 1px solid black !important;'>"); //Empieza Columna Fecha

                                    sbUsoMensual.Append("<table style='width: 100%; border: 1px solid black !important; border-collapse: collapse !important;'>");

                                    sbUsoMensual.Append("<tr>");
                                    sbUsoMensual.Append("<td colspan=2 style='border: 1px solid black !important; background-color: #002f6b !important; color:#fff !important;'>");
                                    sbUsoMensual.Append("<b style='color:#fff !important;'>" + DateTime.Parse(oRowUso["fecha"].ToString()).ToString("dd/MM/yyyy") + "</b>");
                                    sbUsoMensual.Append("</td>");
                                    sbUsoMensual.Append("</tr>");

                                    sbUsoMensual.Append("<tr>");
                                    sbUsoMensual.Append("<td colspan=2 style='border: 1px solid black !important;'>");
                                    string horaEntrada = "";
                                    string horaSalida = "";

                                    try
                                    {
                                        horaEntrada = DateTime.Parse(oRowUso["HoraEntrada"].ToString()).ToString("hh:mm:ss tt");
                                    }
                                    catch (Exception)
                                    {
                                        horaEntrada = oRowUso["HoraEntrada"].ToString();
                                    }

                                    try
                                    {
                                        horaSalida = DateTime.Parse(oRowUso["HoraSalida"].ToString()).ToString("hh:mm:ss tt");
                                    }
                                    catch (Exception)
                                    {
                                        horaSalida = oRowUso["HoraSalida"].ToString();
                                    }

                                    sbUsoMensual.Append(horaEntrada + " - " + horaSalida);

                                    //sbUsoMensual.Append(DateTime.Parse(oRowUso["HoraEntrada"].ToString()).ToString("hh:mm:ss tt") + " - " + DateTime.Parse(oRowUso["HoraSalida"].ToString()).ToString("hh:mm:ss tt"));

                                    sbUsoMensual.Append("</td>");
                                    sbUsoMensual.Append("</tr>");

                                    sbUsoMensual.Append("<tr>");
                                    sbUsoMensual.Append("<td style='border: 1px solid black !important; background-color: #95bef3 !important; color:#fff !important;'>");
                                    sbUsoMensual.Append("<b style='color:#fff !important;'>H</b>");
                                    sbUsoMensual.Append("</td>");
                                    sbUsoMensual.Append("<td style='border: 1px solid black !important; background-color: #d47bbd !important; color:#fff;'>");
                                    sbUsoMensual.Append("<b style='color:#fff !important;'>M</b>");
                                    sbUsoMensual.Append("</td>");
                                    sbUsoMensual.Append("</tr>");

                                    sbUsoMensual.Append("<tr>");
                                    sbUsoMensual.Append("<td style='border: 1px solid black !important;'>");
                                    sbUsoMensual.Append(oRowUso["H"].ToString());
                                    sbUsoMensual.Append("</td>");
                                    sbUsoMensual.Append("<td>");
                                    sbUsoMensual.Append(oRowUso["M"].ToString());
                                    sbUsoMensual.Append("</td>");
                                    sbUsoMensual.Append("</tr>");

                                    sbUsoMensual.Append("<tr>");
                                    sbUsoMensual.Append("<td colspan=2 style='border: 1px solid black !important;'>");
                                    sbUsoMensual.Append("Total: " + oRowUso["total"].ToString());
                                    sbUsoMensual.Append("</td>");
                                    sbUsoMensual.Append("</tr>");

                                    sbUsoMensual.Append("</table>");
                                    sbUsoMensual.Append("</td>"); //Cierra Columna Fecha


                                }
                                sbUsoMensual.Append("<tr>");
                                sbUsoMensual.Append("<td colspan='100%' style='height:20px;'>");
                                sbUsoMensual.Append("&nbsp;");
                                sbUsoMensual.Append("</td>");
                                sbUsoMensual.Append("</tr>");
                                sbUsoMensual.Append("</tr>"); //Cierra fila de Uso Mensual

                            }

                        }
                    }

                    sbUsoMensual.Append("</table>"); //Termina la tabla
                }
               
                ltlEstadistica.Text = EncabezadoUTN("Universidad Técnica Nacional", "Sede central");
                ltlEstadistica.Text += EncabezadaTipo("Reporte del Uso de Espacio", "Reporte del Mes de " + ddlMes_Estadistica.SelectedItem.Text + " del " + ddlAnno_Estadistica.SelectedItem.Text);
                ltlEstadistica.Text += sbUsoMensual.ToString();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void ddlAnno_Estadistica_SelectedIndexChanged(object sender, EventArgs e)
        {
            EstadisticaUsoespacios();
        }

        protected void ddlMes_Estadistica_SelectedIndexChanged(object sender, EventArgs e)
        {
            EstadisticaUsoespacios();
        }

        /*******************************************************************************************/
        /**********                            Funciones Comunes                          **********/
        /*******************************************************************************************/

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

        private void llenarComboEvento(ListBox ddlEvento, int estado)
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


        private string EncabezadoUTN(string linea1, string linea2)
        {
            StringBuilder table = new StringBuilder();
            table.Append("<table style='border: 0px; border-bottom: 1px solid black; width: 100%;'>");
            table.Append("<tr style='border: 0px;'>");
            table.Append("<td style='border: 0px; width: 80px; border-right: 2px solid black;'>");
            table.Append("<img src=");
            table.Append("'../Imagenes/LogoUTN.png'");
            table.Append(" style='width: 68px; height: 55px;' /></td>");
            table.Append("<td style='vertical-align: top; border: 0px; padding-left: 5px;'>");
            table.Append("<span style='font-weight: bold; color: #002f6b;'>");
            table.Append(linea1);
            table.Append("</span><br /><span style='font-weight: bold; color: #002f6b;'>");
            table.Append(linea2);
            table.Append("</span></td></tr></table>");
            table.Append("<br />");

            return table.ToString();


        }

        private string EncabezadaTipo(string titulo1, string tpBitacora)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append("<table style='width: 100%; border: 0px;'>");
            sb.Append("<tr style='border: 0px;'>");
            sb.Append("<td style='border: 0px; background-color: #002f6b !important; color: white !important; padding-top: 10px; padding-bottom: 10px;' align='center'>");
            sb.Append("<span style='font-size: 18px; font-weight: bold; color:#fff !important'>");
            sb.Append(titulo1);
            sb.Append("</span><br />");
            sb.Append("<span style='font-size: 16px; font-weight: bold; padding-top: 5px; color:#fff !important'>");
            sb.Append(tpBitacora);
            sb.Append("</span>");
            sb.Append("</td></tr></table>");
            sb.Append("<br />");


            return sb.ToString();
        }

        protected override void InitializeCulture()
        {
            if (Session["language"] != null)
            {
                Culture = (string)Session["language"];
                UICulture = (string)Session["language"];
            }
        }

        protected void btnGenerarTitulo_Click(object sender, EventArgs e)
        {
            int idPeriodo = 0;
            if (ddlPeriodo_lstMatricula.SelectedIndex != -1)
            {
                idPeriodo = Convert.ToInt32(ddlPeriodo_lstMatricula.SelectedValue);
            }

            int idCurso = 0;

            if (lstEvento_lstMatricula.SelectedIndex != -1)
            {
                idCurso = Convert.ToInt32(lstEvento_lstMatricula.SelectedValue);
            }

            string Titulos = "";

            foreach (DataRow oRow in ReporteBLL.obtenerPersonasIncritas(idCurso,idPeriodo).Rows)
            {
                Titulos += GenerarTitulo(oRow["nombre_Completo"].ToString(), oRow["IdPersona"].ToString(), lstEvento_lstMatricula.SelectedItem.Text);
            }

            ltlContenido_lstMatricula.Text = Titulos.ToString();
        }


    }
}