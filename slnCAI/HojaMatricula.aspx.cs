using BLL;
using QRCoder;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace slnCAI
{
    public partial class HojaMatricula : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                llenarCuerpo();
            }
        }

        private void llenarCuerpo()
        {
            StringBuilder sbTabla = new StringBuilder();
            CultureInfo culture = new CultureInfo("es-CR");
            string idCurso = Request.QueryString["idEvento"];
            string idBimestre = Request.QueryString["idPeriodo"];
            string identificacion = Request.QueryString["identificacion"];

            foreach (DataRow row in ProcesosBLL.obtenerBoletaMatricula(identificacion, idCurso, idBimestre).Tables[0].Rows)
            {
                //Primer Linea Nombre y cedula
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Nombre del Usuario:</td><td style='width:275px;padding-left:5px;'>");
                sbTabla.Append(row["nombre_completo"].ToString());
                sbTabla.Append("</td><td style='font-weight:bold;width:200px; text-align:right;'>Cédula:</td><td style='padding-left:5px;'>");
                sbTabla.Append(row["numero_Identificacion"].ToString());
                sbTabla.Append("</td></tr>");

                //Segunda Linea Telefono1 y fecha Nacimiento
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Celular:</td><td style='width:275px; padding-left:5px;'>");
                sbTabla.Append(row["celular"].ToString());

                sbTabla.Append("</td><td style='font-weight:bold;width:200px; text-align:right;'>Fecha Nacimiento:</td><td style='padding-left:5px;'>");
                sbTabla.Append(string.Format("{0:dd/MM/yyyy}", row["fecha_Nacimiento"]));
                sbTabla.Append("</td></tr>");
                //Tercera Linea Telefono2 y estado Civil
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Teléfono:</td><td style='width:275px; padding-left:5px;'>");
                sbTabla.Append(row["telefono"].ToString());
                sbTabla.Append("</td><td style='font-weight:bold;width:200px; text-align:right;'>Estado Civil:</td><td style='padding-left:5px;'>");
                sbTabla.Append(row["estadoCivil"].ToString());
                sbTabla.Append("</td></tr>");
                //Cuarta Linea Direccion y Correo Electronico
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Dirección Exacta:</td><td style='width:290px; padding-left:5px;'>");
                sbTabla.Append(row["direccion"].ToString());
                sbTabla.Append("</td><td style='font-weight:bold;width:200px; text-align:right;'>Correo Electrónico:</td><td style='padding-left:5px;'>");
                sbTabla.Append(row["email"].ToString());
                sbTabla.Append("</td></tr>");
                //Cuarta Linea Sexo y Pais
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Sexo:</td><td style='width:290px; padding-left:5px;'>");
                sbTabla.Append(GetGlobalResourceObject("procesos.language", row["sexo"].ToString()).ToString());
                sbTabla.Append("</td><td style='font-weight:bold;width:200px; text-align:right;'>País:</td><td style='padding-left:5px;'>");
                sbTabla.Append(row["paisNombre"].ToString());
                sbTabla.Append("</td></tr>");
                //Quinta Linea Contacto telefono y nombre
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Contacto Emergencia:</td><td style='width:290px; padding-left:5px;'>");
                sbTabla.Append(row["nombre_Completo_Emergencia"].ToString());
                sbTabla.Append("</td><td style='font-weight:bold;width:200px; text-align:right;'>Teléfono Contacto:</td><td style='padding-left:5px;'>");
                sbTabla.Append(row["telefono_Contacto"].ToString());
                sbTabla.Append("</td></tr>");
                //Situacion Especial
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Situación Especial:</td><td colspan='3' style='padding-left:5px;'>");
                sbTabla.Append(row["situacionEspecial"].ToString());
                sbTabla.Append("</td></tr>");
                //Informacion Curso
                sbTabla.Append("<tr style='background-color:#002f6b !important; color:white !important;'><td colspan='4'><span style='font-weight:bold; color:white !important;'>DATOS DE MATRICULA</span></td></tr>");
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Curso Matriculado:</td><td style='width:290px; padding-left:5px;'>");
                sbTabla.Append(row["nombre_Evento"].ToString());
                sbTabla.Append("</td><td style='font-weight:bold;width:200px; text-align:right;'>Monto:</td><td style='padding-left:5px;'>");
                sbTabla.Append(string.Format(culture, "{0:C}", row["monto"]));
                sbTabla.Append("</td></tr>");
                //Fecha Comprobante y Numero Comprobante
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Fecha Comprobante:</td><td style='width:290px; padding-left:5px;'>");
                sbTabla.Append(string.Format(culture, "{0:dd/MM/yyyy}", row["fechaComprobante"]));
                sbTabla.Append("</td><td style='font-weight:bold;width:220px; text-align:right;'>Número de Comprobante:</td><td style='padding-left:5px;'>");
                sbTabla.Append(row["numComprobante"].ToString());
                sbTabla.Append("</td></tr>");
                //Banco y Firma
                sbTabla.Append("<tr style='height:40px;'><td style='font-weight:bold; width:200px; text-align:right;'>Banco:</td><td style='padding-left:5px;'>");
                sbTabla.Append(row["banco"].ToString());
                sbTabla.Append("</td><td style='font-weight:bold; width:200px; text-align:right;'>Firma:</td><td></td></tr>");
                sbTabla.Append("<tr style='height:34px;'><td style='font-weight:bold; width:200px; text-align:right;'>Observaciones:</td><td colspan='3' style='padding-left:5px;'>");
                sbTabla.Append(row["observaciones"].ToString());
                sbTabla.Append("</td></tr><tr style='height:20px;'><td colspan='4' style='font-weight:bold; font-size:12px;'>NOTA: ");
                sbTabla.Append("No se hacen devoluciones de dinero.<br/>");
                sbTabla.Append("Limitante: Con tres ausencias injustificadas, el estudiante automáticamente pierde la oportunidad de obtener certificado de participación del taller.<br/>");
                sbTabla.Append("Autorizo al Centro de Acceso a la Información (CAI) a utilizar las fotografías tomadas durante el taller con fines publicitarios en las Redes Sociales del CAI.<br/>");
                sbTabla.Append("</td></tr>");
            }
            ltlTabla.Text = sbTabla.ToString();



            ltlQr.Text = crearQr(identificacion, idCurso, idBimestre);

        }

        private string crearQr(string cedula, string idCurso, string idBimestre)
        {
            QRCodeGenerator qrGenerator = new QRCodeGenerator();
            try
            {
                QRCodeData qrCodeData = qrGenerator.CreateQrCode(cedula + ";" + idCurso + ";" + idBimestre, QRCodeGenerator.ECCLevel.Q);
                QRCode qrCode = new QRCode(qrCodeData);
                Bitmap qrCodeImage = qrCode.GetGraphic(20);

                using (MemoryStream ms = new MemoryStream())
                {
                    qrCodeImage.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                    byte[] byteImage = ms.ToArray();

                    Convert.ToBase64String(byteImage);
                    return "<img style='width:200px; height:200px;'  class='img img-resposive' src='" + "data:image/png;base64," + Convert.ToBase64String(byteImage) + "'/>";

                }
            }
            catch (Exception)
            {

                throw;
            }
        }
    }
}