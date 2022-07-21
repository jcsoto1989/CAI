<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="HojaMatricula.aspx.cs" Inherits="slnCAI.HojaMatricula" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        function printContent(el) {
            var restorePage = document.body.innerHTML;
            var print = document.getElementById(el).innerHTML;
            document.body.innerHTML = print;
            window.print();
            document.body.innerHTML = restorePage;
        }
    </script>

    <style>
       
        table#t01, th, td {
            border: 1px solid black;
            border-collapse: collapse;
        }

        #container {
            min-height: 100%;
            position: relative;
            height: 100%;
        }

        #header {
            padding: 10px;
        }

        #body {
            padding: 10px;
            padding-bottom: 60px; /* Height of the footer */
        }

        #footer {
            position: absolute;
            bottom: 0;
            width: 100%;
            height: 60px; /* Height of the footer */
        }

        #sketch {
            border: 10px solid gray;
            height: 100%;
        }

        .wrapper {
            position: relative;
            width: 400px;
            height: 200px;
            -moz-user-select: none;
            -webkit-user-select: none;
            -ms-user-select: none;
            user-select: none;
        }



        .signature-pad {
            position: absolute;
            left: 0;
            top: 0;
            width: 400px;
            height: 200px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <div class="panel panel-default">
            <div class="panel-heading">
                <button id="print1" onclick="printContent('printTable')" class="btn btn-info">Imprimir Boleta Matricula</button>
            </div>
            <div class="panel-body" id="printTable" style="position: relative; font-family: 'Century Gothic'; font-size: 15px;">
                <div id="container2">
                    <div id="Header">
                        <table style="border: 0px; border-bottom: 1px solid black; width: 100%; right: 2px;">
                            <tr style="border: 0px;">
                                <td style="border: 0px; width: 85px; border-right: 2px solid black;">
                                    <img src="../Imagenes/LogoUTN.png" style="width: 78px; height: 65px;" />
                                </td>
                                <td style="vertical-align: top; border: 0px; padding-left: 5px;">
                                    <span style="font-weight: bold; color: #002f6b;">Centro de Acceso a la Información - Costa Rica</span><br />
                                    <span style="font-weight: bold; color: #002f6b;">Sede Central</span>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div id="body">
                        <table style="width: 100%; right: 2px; border: 0px;">
                            <tr style="border: 0px;">
                                <td style="text-align: center; border: 0px; background-color: #002f6b !important; color: white !important; padding-top: 10px; padding-bottom: 10px;">
                                    <span style="font-size: 18px; font-weight: bold; color: white !important;">CENTRO DE ACCESO A LA INFORMACIÓN</span><br />
                                    <span style="font-size: 16px; font-weight: bold; color: white !important; padding-top: 5px;">BOLETA DE MATRICULA</span>
                                </td>
                            </tr>
                        </table>
                        <br />
                        <table style="width: 100%; height: 100%; border: 1px solid black;" id="t01">
                            <tr style="background-color: #002f6b !important; color: #fff !important;">
                                <td style="height: 7%;" colspan="4">
                                    <span style="font-weight: bold; color: white !important;">DATOS PERSONALES</span>
                                </td>
                            </tr>
                            <tr style="height: 20px;">
                                <td colspan="4">
                                    <span style="font-weight: bold;">Favor llenar los datos tal y como aparece en la cédula de la identidad</span>
                                </td>
                            </tr>
                            <!-- Campos de Datos Personales-->
                            <asp:Literal ID="ltlTabla" runat="server"></asp:Literal>
                            <!-- Pie de Pagina -->

                            <tr style="background-color: #002f6b !important; color: #002f6b !important;">
                                <td colspan="4">
                                    <span style="font-weight: bold; color: #002f6b !important;">.</span>
                                </td>
                            </tr>
                        </table>

                    </div>
                    <br />
                    <div>
                        <table style="border: 0px; width: 100%; border-top: 1px solid black;">
                            <tr style="border: 0px; text-align: center;">
                                <td style="border: 0px; padding-top: 5px;">
                                    <span>Universidad Técnica Nacional - Centro de Acceso a la Información</span><br />
                                    <span>(506) 2435-5000 (8930) - Sitio Web: www.utn.ac.cr - email: iac@utn.ac.cr</span>
                                </td>
                            </tr>
                        </table>
                    </div>

                    <p style="page-break-before: always" />
                    <asp:Literal ID="ltlQr" runat="server"></asp:Literal>
                </div>

            </div>
        </div>
    </div>
</asp:Content>
