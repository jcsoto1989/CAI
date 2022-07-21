using BLL;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.DataVisualization.Charting;
using System.Web.UI.WebControls;

namespace slnCAI
{
    public partial class index : System.Web.UI.Page
    {
        StringBuilder str = new StringBuilder();
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                if (Session["Usuario"] != null)
                {
                    chart_bind();
                    ddlMes.SelectedValue = DateTime.Now.Month.ToString();
                    CrearEstadisticaUsoMensual();
                    
                }

            }

        }

        private void CrearEstadisticaUsoMensual()
        {
            StringBuilder sbUsoMensual = new StringBuilder();
            try
            {
                string idMes = ddlMes.SelectedValue;
                string anno = ddlAnno.SelectedValue;

                string hombre = "../Imagenes/SiluetaHombre.png";
                string mujer = "../Imagenes/SiluetaMujer.png";
                int totalMujeres = 0;
                int totalHombres = 0;

                foreach (DataRow oRow in IndexBLL.getEspacioEvento(idMes, anno).Rows)
                {
                    DataTable dt = getUsoMensual(idMes, anno, oRow["idEspacio"].ToString());
                    if (dt.Columns.Count != 0)
                    {
                        double col = 12 / dt.Columns.Count;
                        sbUsoMensual.Append("<div class='panel panel-default'>");
                        sbUsoMensual.Append("<div class='panel-heading'>");
                        sbUsoMensual.Append(oRow["Espacio"].ToString());
                        sbUsoMensual.Append("</div>");
                        sbUsoMensual.Append("<div class='panel-body'>");
                        sbUsoMensual.Append("<div class='flex-container'>"); //Abre Columna
                        totalHombres = 0;
                        totalMujeres = 0;
                        foreach (DataColumn dtColumn in dt.Columns)
                        {
                            sbUsoMensual.Append("<div>"); //Abre Well
                            sbUsoMensual.Append("<h6>");
                            sbUsoMensual.Append(dtColumn.ColumnName);
                            sbUsoMensual.Append("</h6>");
                            int i = 0;
                            sbUsoMensual.Append("<div class='row' style='padding: 5px;'>");
                            sbUsoMensual.Append("");
                            foreach (DataRow dtRow in dt.Rows)
                            {

                                if (i == 0)
                                {
                                    sbUsoMensual.Append("<div style='padding: 2px' class='col-sm-6'>");
                                    sbUsoMensual.Append("<div class='containeri'>");
                                    sbUsoMensual.Append("<img src=" + mujer + " alt='Mujer' style='width:100%;'>");
                                    sbUsoMensual.Append("<div class='centeredi'>");
                                    sbUsoMensual.Append(dtRow[dtColumn.ColumnName].ToString());
                                    totalMujeres += Convert.ToInt32(dtRow[dtColumn.ColumnName].ToString());
                                    sbUsoMensual.Append("</div>");
                                    sbUsoMensual.Append("</div>");
                                    sbUsoMensual.Append("</div>");
                                    i++;
                                }
                                else
                                {
                                    sbUsoMensual.Append("<div style='padding: 2px' class='col-sm-6'>");
                                    sbUsoMensual.Append("<div class='containeri'>");
                                    sbUsoMensual.Append("<img src=" + hombre + " alt='Mujer' style='width:100%;'>");
                                    sbUsoMensual.Append("<div class='centeredi'>");
                                    sbUsoMensual.Append(dtRow[dtColumn.ColumnName].ToString());
                                    try
                                    {
                                        totalHombres += Convert.ToInt32(dtRow[dtColumn.ColumnName].ToString());
                                    }
                                    catch (Exception)
                                    {
                                        totalHombres += 0;
                                    }
                                    sbUsoMensual.Append("</div>");
                                    sbUsoMensual.Append("</div>");
                                    sbUsoMensual.Append("</div>");
                                }
                                //sbUsoMensual.Append("</div>");
                            }
                            sbUsoMensual.Append("</div>");
                            sbUsoMensual.Append("");
                            sbUsoMensual.Append("");
                            sbUsoMensual.Append("");
                            sbUsoMensual.Append("</div>");
                            
                        }
                        sbUsoMensual.Append("</div>");
                        sbUsoMensual.Append("</div>");
                        sbUsoMensual.Append("<div class='panel-footer'>");
                        sbUsoMensual.Append("<img src='../Imagenes/SiluetaMujer1.png' alt='Mujeres' style='width:12px;'>" + totalMujeres + " <img src='../Imagenes/SiluetaHombre1.png' alt='Hombres' style='width:12px;'>" + totalHombres);
                        sbUsoMensual.Append("</div>");
                        sbUsoMensual.Append("</div>");
                    }
                    
                }



            }
            catch (Exception ex)
            {
                Literal1.Text = ex.ToString();
            }
            ltlUsoMensualSexo.Text = sbUsoMensual.ToString();
        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            if (Session["Usuario"] != null)
            {
                foreach (DataRow item in IndexBLL.obtenerFechaEventos().Rows)
                {
                    if (e.Day.Date == Convert.ToDateTime(item["fecha"].ToString()))
                    {
                        Literal ltr = new Literal();
                        StringBuilder stringbd = new StringBuilder();
                        stringbd.Append("<pre style='margin: 0px;border: 0px;padding: 1px;border-radius: 0px;background-color: transparent;'><a href='#' data-placement='top' data-toggle='popover' data-trigger='focus' data-html='true' title='" + item["nombre_Evento"] + "' data-content='<b>Espacio: </b>" + item["espacio"] + "<br><b>Horario: </b>" + item["horaInicio"] + " a " + item["HoraFinal"] + "<br><b>Encargado: </b>" + item["nombre_Completo"] + "' class='");
                        switch (item["idEspacio"].ToString())
                        {
                            case "1": //Internet Room
                                stringbd.Append("label label-success Elipsis' style='background-color:#097138;'> " + item["nombre_Evento"] + "</a></pre>");
                                break;
                            case "2": //Trainnin Room
                                stringbd.Append("label label-primary Elipsis' style='background-color:#0377da;'>" + item["nombre_Evento"] + "</a></pre>");
                                break;
                            case "3": //Seminar Room
                                stringbd.Append("label label-info Elipsis' style='background-color:#f07139;'>" + item["nombre_Evento"] + "</a></pre>");
                                break;
                            case "4": //Mobile Zone
                                stringbd.Append("label label-default Elipsis' style='background-color:#109618;'>" + item["nombre_Evento"] + "</a></pre>");
                                break;


                            default:
                                stringbd.Append("label label-default Elipsis'>" + item["nombre_Evento"] + "</a><br>");
                                break;
                        }

                        ltr.Text = stringbd.ToString();

                        //ltr.Text = "<br/><a href='#' data-placement='top' data-toggle='popover' data-html='true' title='" + item["nombre_Evento"] + "' data-content='<b>Espacio:</b>" + item["espacio"] + "<br><b>Horario:</b>" + item["horaInicio"] + " a " + item["HoraFinal"] + "<br><b>Encargado:</b>" + item["nombre_Completo"] + "' class='label label-default Elipsis'>" + item["nombre_Evento"] + "</a>";

                        e.Cell.Controls.Add(ltr);
                        e.Cell.CssClass = "Elipsis";
                    }
                }

                if (e.Day.IsToday)
                {

                    //e.Cell.BorderColor = System.Drawing.Color.Navy;
                    //e.Cell.BorderStyle = BorderStyle.Inset;
                    //e.Cell.BorderWidth = 1; Elipsis
                    e.Cell.CssClass = "shadow Elipsis";
                }

            }
            /*
            DateTime oDay = new DateTime(2019, 11, 28);
            DateTime oDay1 = new DateTime(2019, 11, 20);
            if (e.Day.Date == oDay)
            {
                //e.Cell.BackColor = System.Drawing.Color.LightSkyBlue;
                Literal ltr = new Literal();

                ltr.Text = "<br/><a href='#' data-toggle='popover' data-html='true' title='Taller Introductorio' data-content='<b>Espacio:</b>Internet Room<br><b>Horario:</b>8:00am a 11:30am<br><b>Encargado:</b>Jose Antonio' class='label label-default'>Taller Introductorio</a>";
                e.Cell.Controls.Add(ltr);
            }

            if (e.Day.Date == oDay1)
            {
                //e.Cell.BackColor = System.Drawing.Color.LightSkyBlue;
                Literal ltr = new Literal();

                ltr.Text = "<br/><a href='#' data-html='true' data-toggle='tooltip' data-placement='top' title='Espacio: Internet Room/9:00am a 11:30am' class='label label-default'>Taller Redes Sociales</a>";
                e.Cell.Controls.Add(ltr);
            }*/
        }


        private void chart_bind()
        {

            DataTable dt = new DataTable();

            try
            {
                dt = crearTablaGrafico();

                if (dt.Rows.Count != 0)
                {
                    List<string> Columns = new List<string>();

                    foreach (DataColumn col in dt.Columns)
                    {
                        Columns.Add(col.ColumnName);
                    }
                    str.Append("<script type='text/javascript'>");
                    str.Append("google.charts.load('current', {'packages':['corechart']});");
                    str.Append("google.charts.setOnLoadCallback(drawChart);");
                    str.Append("function drawChart() {");
                    str.Append("var data = google.visualization.arrayToDataTable([");
                    str.Append("[");
                    int j = 0;
                    foreach (string meses in Columns)
                    {
                        str.Append("'" + meses + "'");
                        if (j != (Columns.Count - 1))
                        {
                            str.Append(",");
                        }
                        j++;
                    }
                    str.Append("],");

                    /*   ['2004',  1000,      400],  */


                    int x = 0;
                    foreach (DataRow row in dt.Rows)
                    {
                        str.Append("[");
                        for (int i = 0; i < dt.Columns.Count; i++)
                        {
                            if (i == 0)
                            {
                                str.Append("'" + GetGlobalResourceObject("index.language", row[i].ToString()).ToString() + "',");
                            }
                            else
                            {
                                if (i != (dt.Columns.Count - 1))
                                {
                                    str.Append(row[i].ToString() + ",");
                                }
                                else
                                {
                                    str.Append(row[i].ToString());
                                }
                            }
                        }
                        if (x != (dt.Rows.Count))
                        {
                            str.Append("],");
                        }
                        else
                        {
                            str.Append("]");
                        }
                        x++;

                    }
                    str.Append("]);");
                    str.Append("var options = {curveType: 'function', legend: { position:'bottom' }, colors: ['#097138', '#0377da', '#f07139', '#0377da']};");
                    str.Append("var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));");
                    str.Append("chart.draw(data, options);");
                    str.Append("}");
                    str.Append("</script>");
                    Literal1.Text = str.ToString().Replace('*', '"');
                }


            }
            catch
            {
                //ltlMessage.Text = "Error al cargar el grafico";
            }

        }

        protected static DataTable crearTablaGrafico()
        {
            try
            {

                DataTable dtUsoMensual = new DataTable();
                List<int> lstEspacio = new List<int>();
                dtUsoMensual.Columns.Add("Mes");

                foreach (DataRow oRow in IndexBLL.obtenerEspacios().Rows)
                {
                    dtUsoMensual.Columns.Add(oRow["Espacio"].ToString());
                    lstEspacio.Add(Convert.ToInt32(oRow["IdEspacio"].ToString()));
                }

                for (int i = 1; i <= 12; i++)
                {
                    DataRow dtRow = dtUsoMensual.NewRow();
                    DateTime date = new DateTime(2020, i, 1);
                    dtRow[0] = date.ToString("MMMM");
                    foreach (int idEspacio in lstEspacio)
                    {
                        foreach (DataRow oRow in IndexBLL.obtenerUsoMensual(i, idEspacio, DateTime.Now.Year).Rows)
                        {
                            dtRow[idEspacio] = oRow[0].ToString();
                        }
                    }
                    dtUsoMensual.Rows.Add(dtRow);
                }

                return dtUsoMensual;


            }
            catch (Exception)
            {

                throw;
            }
        }

        private static DataTable getUsoMensual(string mes, string anno, string idEspacio)
        {
            try
            {
                DataTable dtUsoMensual = new DataTable();
                DataRow drFemale = dtUsoMensual.NewRow();
                dtUsoMensual.Rows.Add(drFemale);
                DataRow drMale = dtUsoMensual.NewRow();
                dtUsoMensual.Rows.Add(drMale);
                int idColumn = 0, idRow = 0;

                foreach (DataRow oRowEvento in IndexBLL.getEventos(mes, anno, idEspacio).Rows)
                {
                    if (ReporteBLL.getUsoMensualSexo(mes, anno, Convert.ToInt32(oRowEvento["idEvento"].ToString())).Rows.Count != 0)
                    {


                        dtUsoMensual.Columns.Add(oRowEvento["nombre_Evento"].ToString());
                        idRow = 0;
                        foreach (DataRow oRowUsoMensual in ReporteBLL.getUsoMensualSexo(mes, anno, Convert.ToInt32(oRowEvento["idEvento"].ToString())).Rows)
                        {

                            //dtUsoMensual.Rows.Add(oRowUsoMensual[1].ToString());
                            dtUsoMensual.Rows[idRow][idColumn] = oRowUsoMensual[1].ToString();
                            idRow++;
                        }
                        idColumn++;
                    }
                }


                return dtUsoMensual;

            }
            catch (Exception)
            {

                throw;
            }
        }

        protected void ddlMes_SelectedIndexChanged(object sender, EventArgs e)
        {
            CrearEstadisticaUsoMensual();
        }

        protected void ddlAnno_SelectedIndexChanged(object sender, EventArgs e)
        {
            CrearEstadisticaUsoMensual();
        }
    }
}