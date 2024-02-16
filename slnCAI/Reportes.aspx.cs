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
using AjaxControlToolkit;
using Entidad;

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
                                llenarComboPeriodo(ddlPeriodo_lstMatricula, 2);
                                llenarComboEvento(lstEvento_lstMatricula, 0);
                                break;
                            case "tabEstadistica1":
                                EstadisticaUsoespacios();
                                break;
                            case "tabAsistencia1":
                                llenarComboPeriodo(ddlPeriodo_Asistencia, 2);
                                llenarComboEvento(ddlEvento_Asistencia, 1);
                                break;

                            case "tabInventario1":
                                llenarComboEspacio(ddlEspacio_Inventario);
                                llenarComboEncargados();
                                llenarComboTipo();
                                llenarComboEstado();
                                break;

                            case "tabEvento1":
                                llenarComboPeriodo(ddlPeriodo_Evento, 2);
                                llenarComboEspacio(ddlEspacio_Evento);
                                llenarComboEvento(lstEvento_Evento, 1);
                                break;

                            case "tabEstudiante1":
                                llenarComboTipoBusquedad();
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
            GenerarQR(false);
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
                    encabezadoTable.Append("<th style='width: 100px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Edad");
                    encabezadoTable.Append("</th>");
                    encabezadoTable.Append("<th style='width: 100px; text-align: center; color:#fff !important;'>");
                    encabezadoTable.Append("Cumpleaños");
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
                        string nacimiento = Convert.ToDateTime(row["fecha_Nacimiento"]).ToString("yyyy,MM,dd");
                        string mesNacimiento = Convert.ToDateTime(row["fecha_Nacimiento"]).ToString("dd MMMM");
                        DateTime nac = Convert.ToDateTime(nacimiento);
                        int edad = DateTime.Today.AddTicks(-nac.Ticks).Year - 1;
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
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(edad);
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(mesNacimiento);
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
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(edad); 
                            table.Append("</td><td style='border: 1px solid black !important;'>");
                            table.Append(mesNacimiento);
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

        private void GenerarQR(bool soloCedula)
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
                        string cadenaQr = "";
                        if(soloCedula == false) {
                         cadenaQr = row["idTipoId"].ToString() + ";" + row["IdPersona"].ToString() + ";" + idEvento + ";" + idPeriodo;
                        }
                        else
                        {
                            cadenaQr = row["IdPersona"].ToString();
                        }
                        QRCodeData qrCodeData = qrGenerator.CreateQrCode(cadenaQr, QRCodeGenerator.ECCLevel.Q);
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
                            sbImagenes.Append("<div style='width:100%; font-size: 11px;color: #fff!important; -webkit-text-stroke: 0px #000; position: absolute;top: 92%;left: 50%;transform: translate(-50%, -50%);mix-blend-mode: difference!important; font-weight: bolder!important; padding: 5px!important; border-radius: 15px !important; '>");
                            sbImagenes.Append(row["nombre_completo"].ToString().Substring(0, row["nombre_completo"].ToString().IndexOf(' ')) + " - " + row["IdPersona"]);
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

                ltlEstadistica.Text = EncabezadoUTN("Universidad Técnica Nacional", "Sede Central");
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
        /**********                              Tab Asistencia                           **********/
        /*******************************************************************************************/

        private void crearTablaAsistencia()
        {
            int idEvento = Convert.ToInt32(ddlEvento_Asistencia.SelectedValue);
            int idPeriodo = Convert.ToInt32(ddlPeriodo_Asistencia.SelectedValue);

            DataTable dtFechas = ReporteBLL.getFechasCurso(idEvento, idPeriodo);
            DataTable dtPersonaInscritas = ReporteBLL.obtenerPersonasIncritas(idEvento, idPeriodo);

            StringBuilder sbTablaAsistencia = new StringBuilder();
            sbTablaAsistencia.Append("<table style='width:100%; border: 1px solid black !important; border-collapse: collapse !important; font-family: Century Gothic;text-align: center;'>");
            sbTablaAsistencia.Append("<tr>");
            sbTablaAsistencia.Append("<th style='border: 1px solid black !important; background-color: #002f6b !important; color:#fff !important;padding: 1px; font-size: 9pt; text-align: center;'>");
            sbTablaAsistencia.Append("Identificación");
            sbTablaAsistencia.Append("</th>");
            sbTablaAsistencia.Append("<th style='border: 1px solid black !important; background-color: #002f6b !important; color:#fff !important;padding: 1px; font-size: 9pt; text-align: center;'>");
            sbTablaAsistencia.Append("Nombre Completo");
            sbTablaAsistencia.Append("</th>");

            foreach (DataRow oRowFecha in dtFechas.Rows)
            {
                sbTablaAsistencia.Append("<th style='border: 1px solid black !important; background-color: #002f6b !important; color:#fff !important;padding: 1px; font-size: 9pt;' text-align: center;>");
                sbTablaAsistencia.Append(Convert.ToDateTime(oRowFecha["fecha"].ToString()).ToString("dd/MM/yyyy"));
                sbTablaAsistencia.Append("</th>");
            }
            sbTablaAsistencia.Append("</tr>");
            int count = 1;
            foreach (DataRow oRowParticipante in dtPersonaInscritas.Rows)
            {
                if (count % 2 == 0)
                {
                    sbTablaAsistencia.Append("<tr style='border: 1px solid black !important;padding: 1px; font-size: 9pt; background-color:#9aa6f7 !important;'>");
                }
                else
                {
                    sbTablaAsistencia.Append("<tr style='border: 1px solid black !important;padding: 1px; font-size: 9pt;'>");
                }

                sbTablaAsistencia.Append("<td style='border: 1px solid black !important;padding: 1px; font-size: 9pt;' >");
                sbTablaAsistencia.Append(oRowParticipante["IdPersona"].ToString());
                sbTablaAsistencia.Append("</td>");
                sbTablaAsistencia.Append("<td style='border: 1px solid black !important;padding: 1px; font-size: 9pt;' >");
                sbTablaAsistencia.Append(oRowParticipante["nombre_Completo"].ToString());
                sbTablaAsistencia.Append("</td>");
                foreach (DataRow oRowFecha in dtFechas.Rows)
                {

                    string fecha = Convert.ToDateTime(oRowFecha["fecha"].ToString()).ToString("yyyy/MM/dd");
                    string ID = oRowParticipante["IdPersona"].ToString();
                    sbTablaAsistencia.Append("<td style='border: 1px solid black !important;padding: 1px; font-size: 9pt;text-align: center;'>");

                    DataTable dtAsistencia = ReporteBLL.getAsistencia(idEvento, idPeriodo, fecha, ID);

                    if (dtAsistencia.Rows.Count == 0 && DateTime.Compare(Convert.ToDateTime(fecha), DateTime.Now) < 0)
                    {
                        sbTablaAsistencia.Append("Ausente");

                    }
                    else
                    {
                        foreach (DataRow oRowAsistencia in dtAsistencia.Rows)
                        {

                            sbTablaAsistencia.Append("<b>Ingreso:</b> " + oRowAsistencia["horaIngreso"].ToString());
                            sbTablaAsistencia.Append("</br>");
                            sbTablaAsistencia.Append("<b>Salida:</b> " + oRowAsistencia["horaSalida"].ToString());

                        }
                    }

                    sbTablaAsistencia.Append("</td>");
                }
                sbTablaAsistencia.Append("</tr>");
                count++;
            }

            sbTablaAsistencia.Append("</table>");
            ltlAsistencia.Text = EncabezadoUTN("Universidad Técnica Nacional", "Sede Central") + EncabezadaTipo("Reporte de Asistencia a Eventos", "Reporte del Evento " + ddlEvento_Asistencia.SelectedItem.Text + " del " + ddlPeriodo_Asistencia.SelectedItem.Text) + sbTablaAsistencia.ToString();
        }

        protected void btnConsultar_Asistencia_Click(object sender, EventArgs e)
        {
            crearTablaAsistencia();
        }


        /*******************************************************************************************/
        /**********                              Tab Inventario                           **********/
        /*******************************************************************************************/

        private void llenarComboEncargados()
        {
            ddlEncargado_Inventario.DataSource = MantenimientoBLL.getEncargadoDDL();
            ddlEncargado_Inventario.DataTextField = "nombre_Completo";
            ddlEncargado_Inventario.DataValueField = "numero_Identificacion";
            ddlEncargado_Inventario.DataBind();
            ddlEncargado_Inventario.Items.Insert(0, new ListItem("-- Todos --", ""));
        }

        private void llenarComboTipo()
        {
            ddlTipoEquipo_Inventario.DataSource = MantenimientoBLL.getTipoEquipoDDL();
            ddlTipoEquipo_Inventario.DataTextField = "tipoEquipo";
            ddlTipoEquipo_Inventario.DataValueField = "idTipoEquipo";
            ddlTipoEquipo_Inventario.DataBind();
            ddlTipoEquipo_Inventario.Items.Insert(0, new ListItem("-- Todos --", ""));
        }

        private void llenarComboEstado()
        {
            ddlEstado_Inventario.DataSource = MantenimientoBLL.getCondicion();
            ddlEstado_Inventario.DataTextField = "condicion";
            ddlEstado_Inventario.DataValueField = "idCondicion";
            ddlEstado_Inventario.DataBind();
            ddlEstado_Inventario.Items.Insert(0, new ListItem("-- Todos --", ""));
        }

        protected void btnConsultar_Inventario_Click(object sender, EventArgs e)
        {
            try
            {
                creartablaInventario();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void creartablaInventario()
        {
            string idEspacio = ddlEspacio_Inventario.SelectedValue;
            string idEncargado = ddlEncargado_Inventario.SelectedValue;
            string idTipoEquipo = ddlTipoEquipo_Inventario.SelectedValue;
            string idCondicion = ddlEstado_Inventario.SelectedValue;

            StringBuilder sbInventario = new StringBuilder();
            sbInventario.Append("<table id='tblInventario' style='width:100%; border: 1px solid black !important; border-collapse: collapse !important; font-family: Century Gothic;text-align: center;'>");
            //Creacion de las columnas
            sbInventario.Append("<tr style='border: 1px solid black !important;padding: 1px; font-size: 9pt; background-color:#002f6b !important;color:#fff !important;'>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>ID</th>");
            sbInventario.Append("<th onclick='sortTable(0)' style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Placa</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Serie</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Marca</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Modelo</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Tipo Equipo</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Precio</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Espacio</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Encargado</th>");
            sbInventario.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>Condición</th>");
            sbInventario.Append("</tr>");

            DataTable dtInventario = ReporteBLL.getInventario(idEspacio, idEncargado, idTipoEquipo, idCondicion);

            if (dtInventario.Rows.Count == 0)
            {
                sbInventario.Append("<tr style='border: 1px solid black !important;padding: 1px;>");
                sbInventario.Append("<td colspan='6' style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append("No existen activos registrados en la base de datos");
                sbInventario.Append("</td>");
                sbInventario.Append("</tr>");
            }

            foreach (DataRow oRow in dtInventario.Rows)
            {
                sbInventario.Append("<tr style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["idEquipo"].ToString());
                sbInventario.Append("</td>");
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["placa"].ToString());
                sbInventario.Append("</td>");
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["serie"].ToString());
                sbInventario.Append("</td>");
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["marca"].ToString());
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["modelo"].ToString());
                sbInventario.Append("</td>");
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["tipoEquipo"].ToString());
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                decimal precio = 0;
                if (!string.IsNullOrEmpty(oRow["costoEquipo"].ToString()))
                {
                    precio = Convert.ToDecimal(oRow["costoEquipo"].ToString());
                }
                sbInventario.Append(String.Format("{0:C}", precio));
                sbInventario.Append("</td>");
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["Espacio"].ToString());
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["nombre_Completo"].ToString());
                sbInventario.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                sbInventario.Append(oRow["Condicion"].ToString());
                sbInventario.Append("</td>");
                sbInventario.Append("</tr>");
            }

            //Fin de la creacion de columnas

            sbInventario.Append("<table>");
            ltlInventario.Text = EncabezadoUTN("Universidad Técnica Nacional", "Sede Central") + EncabezadaTipo("CENTRO DE ACCESO A LA INFORMACIÓN", "Reporte de Inventario al " + DateTime.Now.ToString("dd/MM/yyyy")) + sbInventario.ToString();
        }

        /*******************************************************************************************/
        /**********                              Tab Evento                           **********/
        /*******************************************************************************************/

        protected void ddlEspacio_Evento_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(ddlEspacio_Evento.SelectedValue))
            {
                llenarComboEvento(lstEvento_Evento, 1);
            }
            else
            {
                string idEspacio = ddlEspacio_Evento.SelectedValue;
                string idPeriodo = ddlPeriodo_Evento.SelectedValue;
                llenarComboEvento(lstEvento_Evento, idEspacio, idPeriodo);
            }
        }

        private void llenarComboEvento(ListBox lstEvento, String idEspacio, string idPeriodo)
        {
            try
            {
                lstEvento.DataSource = ReporteBLL.getEventosEspacios(idEspacio, idPeriodo);
                lstEvento.DataValueField = "idEvento";
                lstEvento.DataTextField = "nombre_Evento";
                lstEvento.DataBind();
            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void btnConsultar_Evento_Click(object sender, EventArgs e)
        {
            try
            {
                crearTablaEvento();
            }
            catch (Exception)
            {

                throw;
            }
        }

        private void crearTablaEvento()
        {
            string idEspacio = ddlEspacio_Evento.SelectedValue;
            string idPeriodo = ddlPeriodo_Evento.SelectedValue;
            DataTable dtEventos = ReporteBLL.getEventosEspacios(idEspacio, idPeriodo);
            StringBuilder sb = new StringBuilder();

            int itemsSelect = 0;

            foreach (ListItem item in lstEvento_Evento.Items)
            {
                if (item.Selected)
                {
                    itemsSelect++;
                }
            }

            if (itemsSelect != 0)
            {
                foreach (ListItem oRowEvento in lstEvento_Evento.Items)
                {
                    if (oRowEvento.Selected)
                    {
                        sb.Append("<h3>" + oRowEvento.Text + "</h3>");
                        sb.Append("<table style='width:100%; border: 1px solid black !important; border-collapse: collapse !important; font-family: Century Gothic;text-align: center;'>");

                        DataTable dt = ReporteBLL.getEventos(oRowEvento.Value, idEspacio, idPeriodo);
                        sb.Append("<tr style='border: 1px solid black !important;padding: 1px; font-size: 11pt; background-color:#002f6b !important;color:#fff !important;'><th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                        sb.Append("Espacio");
                        sb.Append("</th>");

                        sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                        sb.Append("Fecha");
                        sb.Append("</th>");

                        sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                        sb.Append("Hora Inicio");
                        sb.Append("</th>");

                        sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                        sb.Append("Hora Final");
                        sb.Append("</th>");

                        sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                        sb.Append("Encargado");
                        sb.Append("</th></tr>");
                        int i = 1;
                        foreach (DataRow oRowEventos in dt.Rows)
                        {
                            if (i % 2 == 0)
                            {
                                sb.Append("<tr style='border: 1px solid black !important;padding: 1px; background-color:#9aa6f7 !important;'>");
                            }
                            else
                            {
                                sb.Append("<tr style='border: 1px solid black !important;padding: 1px;'>");
                            }
                            sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                            sb.Append(oRowEventos["Espacio"].ToString());
                            sb.Append("</td>");

                            sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                            sb.Append(Convert.ToDateTime(oRowEventos["Fecha"].ToString()).ToString("dd/MM/yyyy"));
                            sb.Append("</td>");

                            sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                            sb.Append(Convert.ToDateTime(oRowEventos["horaInicio"].ToString()).ToString("hh:mm tt"));
                            sb.Append("</td>");

                            sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                            sb.Append(Convert.ToDateTime(oRowEventos["horaFinal"].ToString()).ToString("hh:mm tt"));
                            sb.Append("</td>");

                            sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                            sb.Append(oRowEventos["nombre_Completo"].ToString());
                            sb.Append("</td></tr>");
                            i++;
                        }
                        sb.Append("</table>");
                    }

                }
            }
            else
            {
                foreach (DataRow oRowEvento in dtEventos.Rows)
                {
                    sb.Append("<h3>" + oRowEvento["nombre_Evento"].ToString() + "</h3>");
                    sb.Append("<table style='width:100%; border: 1px solid black !important; border-collapse: collapse !important; font-family: Century Gothic;text-align: center;'>");

                    DataTable dt = ReporteBLL.getEventos(oRowEvento["idEvento"].ToString(), idEspacio, idPeriodo);
                    sb.Append("<tr style='border: 1px solid black !important;padding: 1px; font-size: 11pt; background-color:#002f6b !important;color:#fff !important;'><th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                    sb.Append("Espacio");
                    sb.Append("</th>");

                    sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                    sb.Append("Fecha");
                    sb.Append("</th>");

                    sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                    sb.Append("Hora Inicio");
                    sb.Append("</th>");

                    sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                    sb.Append("Hora Final");
                    sb.Append("</th>");

                    sb.Append("<th style='text-align: center;border: 1px solid black !important;color:#fff !important;'>");
                    sb.Append("Encargado");
                    sb.Append("</th></tr>");
                    int i = 1;
                    foreach (DataRow oRowEventos in dt.Rows)
                    {
                        if (i % 2 == 0)
                        {
                            sb.Append("<tr style='border: 1px solid black !important;padding: 1px; background-color:#9aa6f7 !important;'>");
                        }
                        else
                        {
                            sb.Append("<tr style='border: 1px solid black !important;padding: 1px;'>");
                        }
                        sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                        sb.Append(oRowEventos["Espacio"].ToString());
                        sb.Append("</td>");

                        sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                        sb.Append(Convert.ToDateTime(oRowEventos["Fecha"].ToString()).ToString("dd/MM/yyyy"));
                        sb.Append("</td>");

                        sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                        sb.Append(Convert.ToDateTime(oRowEventos["horaInicio"].ToString()).ToString("hh:mm tt"));
                        sb.Append("</td>");

                        sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                        sb.Append(Convert.ToDateTime(oRowEventos["horaFinal"].ToString()).ToString("hh:mm tt"));
                        sb.Append("</td>");

                        sb.Append("<td style='border: 1px solid black !important;padding: 1px;'>");
                        sb.Append(oRowEventos["nombre_Completo"].ToString());
                        sb.Append("</td></tr>");
                        i++;
                    }
                    sb.Append("</table>");

                }
            }




            ltlEvento.Text = EncabezadoUTN("Universidad Técnica Nacional", "Sede Central") + EncabezadaTipo("CENTRO DE ACCESO A LA INFORMACIÓN", "Reporte de Eventos") + sb.ToString();
        }
        /*******************************************************************************************/
        /**********                              Tab Estudiante                           **********/
        /*******************************************************************************************/

        protected void ddlTipoBusqueda_Estudiante_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (ddlTipoBusqueda_Estudiante.SelectedValue)
            {
                case "ID":
                    ltlTipoBusqueda.Text = "<label>Digite el ID a consultar</label>";
                    llenarComboEstudiante(cboBusqueda_Estudiante, "numero_identificacion", "numero_identificacion");

                    break;
                case "Nombre":
                    ltlTipoBusqueda.Text = "<label>Digite el Nombre a consultar</label>";
                    llenarComboEstudiante(cboBusqueda_Estudiante, "nombre_Completo", "numero_identificacion");
                    break;

                case "seleccione":
                    cboBusqueda_Estudiante.Items.Clear();
                    break;
                default:
                    break;
            }
        }

        private void llenarComboEstudiante(ComboBox cboBusqueda_Estudiante, string DataText, string DataValue)
        {
            try
            {
                cboBusqueda_Estudiante.DataSource = ProcesosBLL.obtenerPersona();
                cboBusqueda_Estudiante.DataTextField = DataText;
                cboBusqueda_Estudiante.DataValueField = DataValue;
                cboBusqueda_Estudiante.DataBind();
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

        protected void btnConsultar_Estudiante_Click(object sender, EventArgs e)
        {
            creartablaEstudiante();
        }

        private void creartablaEstudiante()
        {
            string ID = cboBusqueda_Estudiante.SelectedValue;
            //string busqueda = txtBusqueda_Estudiante.Text;
            DataTable dt = ReporteBLL.obtenerPersona(ID);
            StringBuilder sb = new StringBuilder();
            sb.Append("<table style='width:100%; font-family: Century Gothic;text-align: center;'>");


            if (dt.Rows.Count > 0)
            {
                //Fila 1
                sb.Append("<tr style='border-radius: 5px;padding: 1px; font-size: 11pt; background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("<td colspan='6' style='padding: 1px;border-radius: 5px;color:#fff !important;'>");
                sb.Append("<h3 style='color:#fff !important;'>" + dt.Rows[0][2].ToString() + "</h3>"); //Nombre Completo
                sb.Append("</td>");
                sb.Append("</tr>");

                //Fila 2
                sb.Append("<tr>");
                sb.Append("<td colspan='6' style='padding: 1px;'>");
                sb.Append("<h4  style='font-weight: bold;'>Información Personal</h4>");
                sb.Append("</td>");
                sb.Append("</tr>");



                //Fila 3
                sb.Append("<tr>");
                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Cédula"); //Cedula
                sb.Append("</td>");

                sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][1].ToString()); //Cedula
                sb.Append("</td>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Celular"); //Celular
                sb.Append("</td>");
                sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][3].ToString()); //celular
                sb.Append("</td>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Teléfono"); //Telefono
                sb.Append("</td>");
                sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][4].ToString()); //Telefono
                sb.Append("</td>");
                sb.Append("</tr>");

                //Fiala
                sb.Append("<tr>");
                sb.Append("<td colspan='6' style='padding: 1px;'>");
                sb.Append("<br/>");
                sb.Append("</td>");
                sb.Append("</tr>");


                //Fila 4
                sb.Append("<tr>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Correo Electrónico"); //Email
                sb.Append("</td>");
                sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][5].ToString()); //Email
                sb.Append("</td>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Estado Civil"); //Estado Civil
                sb.Append("</td>");
                sb.Append("<td style='border-bottom:1px solid black;padding: 1px;'>");
                sb.Append(dt.Rows[0][6].ToString()); //Estado Civil
                sb.Append("</td>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Fecha de Nacimiento"); //Fecha de Nacimiento
                sb.Append("</td>");
                sb.Append("<td style='border-bottom:1px solid black;padding: 1px;'>");
                sb.Append(Convert.ToDateTime(dt.Rows[0][7].ToString()).ToString("dd/MM/yyyy")); //Fecha de Nacimiento
                sb.Append("</td>");

                sb.Append("</tr>");

                //Fila
                sb.Append("<tr>");
                sb.Append("<td colspan='6' style='padding: 1px;'>");
                sb.Append("<br/>");
                sb.Append("</td>");
                sb.Append("</tr>");

                //Fila
                sb.Append("<tr>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Sexo"); //Sexo
                sb.Append("</td>");
                sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                if (dt.Rows[0][9].ToString().Equals("male"))
                {
                    sb.Append("Masculino"); //Sexo
                }
                else
                {
                    sb.Append("Femenino");
                }
                sb.Append("</td>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("País de Origen"); //Pais
                sb.Append("</td>");
                sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][10].ToString()); //Pais
                sb.Append("</td>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Edad"); //Edad
                sb.Append("</td>");
                sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(DateTime.Now.Year - Convert.ToDateTime(dt.Rows[0][7].ToString()).Year); //Edad
                sb.Append("</td>");

                sb.Append("</tr>");

                //Fila
                sb.Append("<tr>");
                sb.Append("<td colspan='6' style='padding: 1px;'>");
                sb.Append("<br/>");
                sb.Append("</td>");
                sb.Append("</tr>");

                sb.Append("<tr>");
                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Dirección"); //Direccion
                sb.Append("</td>");
                sb.Append("<td colspan='5' style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][8].ToString()); //Direccion
                sb.Append("</td>");
                sb.Append("</tr>");



                //Fila
                sb.Append("<tr>");
                sb.Append("<td colspan='6' style='padding: 1px;'>");
                sb.Append("<br/>");
                sb.Append("</td>");
                sb.Append("</tr>");

                //Fila
                sb.Append("<tr>");
                sb.Append("<td  style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Observaciones"); //Observaciones
                sb.Append("</td>");
                sb.Append("<td colspan='5' style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][13].ToString()); //Observaciones
                sb.Append("</td>");
                sb.Append("</tr>");


                //Fila
                sb.Append("<tr>");
                sb.Append("<td colspan='6' style='padding: 1px;'>");
                sb.Append("<br/><h4 style='font-weight: bold;'>Contacto de Emergencia</h4>");
                sb.Append("</td>");
                sb.Append("</tr>");


                sb.Append("<tr>");

                sb.Append("<td style='border-radius: 5px;border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Nombre"); //Nombre
                sb.Append("</td>");
                sb.Append("<td  colspan='3' style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append(dt.Rows[0][11].ToString()); //Nombre
                sb.Append("</td>");

                sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                sb.Append("Teléfono"); //Telefono
                sb.Append("</td>");
                sb.Append("<td style='border-bottom:1px solid black;padding: 1px;'>");
                sb.Append(dt.Rows[0][12].ToString()); //Telefono
                sb.Append("</td>");
                sb.Append("</tr>");

                //fila
                sb.Append("<tr><td><br/></td></tr>");
                //Fila 2
                sb.Append("<tr>");
                sb.Append("<td colspan='6' style='padding: 1px;border-bottom:1px solid black;'>");
                sb.Append("<h4  style='font-weight: bold;'>Eventos Matriculados</h4>");
                sb.Append("</td>");
                sb.Append("</tr>");
                foreach (DataRow oRow in ReporteBLL.ConsultarPersona(ID).Rows)
                {
                    DateTime fechaInicio = Convert.ToDateTime(oRow["fechaInicio"].ToString());
                    DateTime fechaFinal = Convert.ToDateTime(oRow["fechaFinal"].ToString());

                    sb.Append("<tr>");
                    sb.Append("<td colspan='2'>");
                    sb.Append(oRow["nombre_Evento"].ToString());
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(oRow["periodo_descripcion"].ToString());
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(fechaInicio.ToString("dd/MM/yyyy"));
                    sb.Append("</td>");
                    sb.Append("<td>");
                    sb.Append(fechaFinal.ToString("dd/MM/yyyy"));
                    sb.Append("</td>");

                    if (DateTime.Now >= fechaInicio && DateTime.Now <= fechaFinal)
                    {
                        sb.Append("<td>");
                        sb.Append("Cursando");
                        sb.Append("</td>");
                    }
                    else
                    {
                        if (DateTime.Now > fechaFinal)
                        {
                            sb.Append("<td>");
                            sb.Append("Cursado");
                            sb.Append("</td>");
                        }
                        else
                        {
                            if (DateTime.Now < fechaInicio)
                            {
                                sb.Append("<td>");
                                sb.Append("Por Iniciar");
                                sb.Append("</td>");
                            }
                        }
                    }

                    sb.Append("</tr>");
                }
                //fila
                sb.Append("<tr><td><br/></td></tr>");
                //fila
                sb.Append("<tr style='border-top:1px solid black'><td colspan='6'><br/></td></tr>");

                if (!string.Equals(dt.Rows[0][17].ToString(), "0001-01-01"))
                {
                    //fila
                    sb.Append("<tr>");
                    sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                    sb.Append("Póliza"); //Poliza
                    sb.Append("</td>");
                    sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                    sb.Append(dt.Rows[0][16].ToString()); //Poliza
                    sb.Append("</td>");

                    sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                    sb.Append("Fecha de Compra"); //Fecha Poliza
                    sb.Append("</td>");
                    sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                    sb.Append(Convert.ToDateTime(dt.Rows[0][17].ToString()).ToString("dd/MM/yyyy")); //Poliza
                    sb.Append("</td>");

                    sb.Append("<td style='border-radius: 5px;width: 175px;padding: 1px;background-color:#002f6b !important;color:#fff !important;'>");
                    sb.Append("Fecha de Vencimiento"); //Fecha Poliza
                    sb.Append("</td>");
                    sb.Append("<td style='padding: 1px;border-bottom:1px solid black;'>");
                    sb.Append(Convert.ToDateTime(dt.Rows[0][17].ToString()).AddYears(1).ToString("dd/MM/yyyy")); //Poliza
                    sb.Append("</td>");

                    sb.Append("</tr>");
                }
            }
            else
            {
                sb.Append("<tr>");
                sb.Append("<td>");
                sb.Append("El estudiante no ha estado matriculado en ningún evento");
                sb.Append("</td>");
                sb.Append("</tr>");
            }

            sb.Append("</table>");
            ltlEstudiante.Text = EncabezadoUTN("Universidad Técnica Nacional", "Sede Central") + EncabezadaTipo("CENTRO DE ACCESO A LA INFORMACIÓN", "Reporte de Estudiante") + sb.ToString();
        }



        private void llenarComboTipoBusquedad()
        {
            ddlTipoBusqueda_Estudiante.Items.Add(new ListItem("ID", "ID"));
            ddlTipoBusqueda_Estudiante.Items.Add(new ListItem("Nombre", "Nombre"));
            ddlTipoBusqueda_Estudiante.Items.Insert(0, new ListItem(" - Seleccione un valor - ", "seleccione"));
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
                ddlEspaciop.Items.Insert(0, new ListItem("-- Todos --", ""));
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

            foreach (DataRow oRow in ReporteBLL.obtenerPersonasIncritas(idCurso, idPeriodo).Rows)
            {
                Titulos += GenerarTitulo(oRow["nombre_Completo"].ToString(), oRow["IdPersona"].ToString(), lstEvento_lstMatricula.SelectedItem.Text);
            }

            ltlContenido_lstMatricula.Text = Titulos.ToString();
        }

        protected void ddlPeriodo_Evento_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void btnCrearQR_listaMatriculaCedula_Click(object sender, EventArgs e)
        {
            GenerarQR(true);
        }
    }
}