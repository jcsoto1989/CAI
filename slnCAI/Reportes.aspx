<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Reportes.aspx.cs" Inherits="slnCAI.Reportes" Culture="en-US" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "";
            $('#myTabs a[href="#' + tabId + '"]').tab('show');
            $("#myTabs a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });
        });

        function printContent(el) {
            var restorePage = document.body.innerHTML;
            var print = document.getElementById(el).innerHTML;
            document.body.innerHTML = print;
            window.print();
            document.body.innerHTML = restorePage;
        }
    </script>
    <style>
        .shadow {
            -webkit-box-shadow: 2px 2px 0px 0px #bbb; /* Safari 3-4, iOS 4.0.2 - 4.2, Android 2.3+ */
            -moz-box-shadow: 2px 2px 0px 0px #bbb; /* Firefox 3.5 - 3.6 */
            box-shadow: 2px 2px 0px 0px #bbb; /* Opera 10.5, IE 9, Firefox 4+, Chrome 6+, iOS 5 */
            /*[horizontal offset] [vertical offset] [blur radius] [optional spread radius] [color];*/
            border-left: 1px solid #ddd;
            border-bottom: 1px solid #ddd;
            border-right: 1px solid #ddd;
        }

        .shadow1 {
            -webkit-box-shadow: 5px 5px 5px 0px #333240; /* Safari 3-4, iOS 4.0.2 - 4.2, Android 2.3+ */
            -moz-box-shadow: 5px 5px 5px 0px #333240; /* Firefox 3.5 - 3.6 */
            box-shadow: 5px 5px 5px 0px #333240; /* Opera 10.5, IE 9, Firefox 4+, Chrome 6+, iOS 5 */
            /*[horizontal offset] [vertical offset] [blur radius] [optional spread radius] [color];*/
            border: 1px solid #ddd;
            background-color: #ffffff;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <asp:HiddenField ID="hfTab" runat="server" Value="" />
        <asp:Literal ID="ltlMessage" runat="server"></asp:Literal>
        <div runat="server" id="ReportesPage">
            <div class="panel panel-primary">
                <div class="panel-heading">Reportes</div>
                <div class="panel-body">
                    <!-- Menu de Pestañas - Inicio  -tabs1-->
                    <ul class="nav nav-tabs nav-justified" id="myTabs">
                        <asp:Literal ID="ltlTabs" runat="server"></asp:Literal>
                    </ul>
                    <!-- Menu de Pestañas - Fin -->
                    <!-- Inicio Contenido Pestañas -->

                    <!-- Pestaña Lista de Matricula -->
                    <div class="tab-content">
                        <div id="tabListaMatricula" class="tab-pane fade in">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabListaMatricula1" runat="server">
                                        <br />
                                        <div class="well well-sm shadow1">
                                            <div class="row">
                                                <div class="col-sm-2">
                                                    <div class="form-group-sm">
                                                        <label>Periodo</label>
                                                        <asp:DropDownList ID="ddlPeriodo_lstMatricula" CssClass="form-control input-sm" runat="server"></asp:DropDownList>
                                                    </div>
                                                </div>
                                                <div class="col-sm-3">
                                                    <div class="form-group-sm">
                                                        <label>Evento</label>
                                                        <asp:ListBox ID="lstEvento_lstMatricula" CssClass="form-control input-sm" SelectionMode="Multiple" runat="server" Rows="3"></asp:ListBox>
                                                    </div>
                                                </div>
                                                <div class="col-sm-2">
                                                    <div class="form-group-sm">
                                                        <label style="color: transparent;">.</label><br />
                                                        <asp:Button ID="btnCrearLista_lstMatricula" CssClass="btn btn-primary btn-sm" runat="server" Text="Crear Lista" OnClick="btnCrearLista_lstMatricula_Click" />
                                                        <asp:Button ID="btnCrearQR_listaMatricula" CssClass="btn btn-primary btn-sm" runat="server" Text="Generar QR" OnClick="btnCrearQR_listaMatricula_Click" />

                                                    </div>
                                                </div>
                                                <div class="col-sm-4" style="border-left-style: dashed; border-right-style: dashed; padding-left: 10px;">
                                                    <div class="form-group-sm">
                                                        <label>Uso para generar titulos</label>
                                                        <div class="row">
                                                            <div class="col-sm-4">
                                                                <div class="form-group-sm">
                                                                    <label>Fecha Inicio</label>
                                                                    <asp:TextBox ID="txtFechaInicio" runat="server" TextMode="Date" CssClass="form-control input-sm"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <div class="form-group-sm">
                                                                    <label>Fecha Final</label>
                                                                    <asp:TextBox ID="txtFechaFinal" runat="server" TextMode="Date" CssClass="form-control input-sm"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <div class="form-group-sm">
                                                                    <label style="color: transparent;">.</label><br />
                                                                    <asp:Button ID="btnGenerarTitulo" CssClass="btn btn-primary btn-sm" runat="server" Text="Generar Titulos" OnClick="btnGenerarTitulo_Click" />
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>

                                                <div class="col-sm-1 text-right">
                                                    <label style="color: transparent;">.</label><br />
                                                    <button id="print" onclick="printContent('divContenido_lstMatricula')" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-print"></span>Imprimir</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="well well-sm shadow1" id="divContenido_lstMatricula">
                                            <asp:Literal ID="ltlContenido_lstMatricula" runat="server"></asp:Literal>
                                            <asp:Literal ID="ltlPieMatriculados" runat="server"></asp:Literal>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Fin Pestaña Lista de Matricula -->

                        <!-- Pestaña estadistica -->
                        <div id="tabEstadistica" class="tab-pane fade in">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabEstadistica1" runat="server">
                                        <br />
                                        <div class="well well-sm shadow1">
                                            <div class="row">
                                                <div class="col-sm-3">
                                                    <asp:DropDownList ID="ddlMes_Estadistica" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlMes_Estadistica_SelectedIndexChanged" AutoPostBack="true">
                                                        <asp:ListItem Text="Enero" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Febrero" Value="2"></asp:ListItem>
                                                        <asp:ListItem Text="Marzo" Value="3"></asp:ListItem>
                                                        <asp:ListItem Text="Abril" Value="4"></asp:ListItem>
                                                        <asp:ListItem Text="Mayo" Value="5"></asp:ListItem>
                                                        <asp:ListItem Text="Junio" Value="6"></asp:ListItem>
                                                        <asp:ListItem Text="Julio" Value="7"></asp:ListItem>
                                                        <asp:ListItem Text="Agosto" Value="8"></asp:ListItem>
                                                        <asp:ListItem Text="Setiembre" Value="9"></asp:ListItem>
                                                        <asp:ListItem Text="Octubre" Value="10"></asp:ListItem>
                                                        <asp:ListItem Text="Noviembre" Value="11"></asp:ListItem>
                                                        <asp:ListItem Text="Diciembre" Value="12"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-3">
                                                    <asp:DropDownList ID="ddlAnno_Estadistica" runat="server" CssClass="form-control input-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlAnno_Estadistica_SelectedIndexChanged">
                                                        <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                                <div class="col-sm-3 text-right">
                                                    <button id="printEstadistica" onclick="printContent('divContenido_Estadistica')" class="btn btn-default btn-sm"><span class="glyphicon glyphicon-print"></span>Imprimir</button>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="well well-sm shadow1" id="divContenido_Estadistica">
                                            <asp:Literal ID="ltlEstadistica" runat="server"></asp:Literal>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Fin Pestana estadistica -->

                        <!-- Pestaña Asistencia -->
                        <div id="tabAsistencia" class="tab-pane fade in">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabAsistencia1" runat="server">
                                        <br />
                                        <div class="well well-sm shadow1">
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Fin Pestaña Asistencia-->

                        <!-- Pestaña Inventario -->
                        <div id="tabInventario" class="tab-pane fade in">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabInventario1" runat="server">
                                        <br />
                                        <div class="well well-sm shadow1">
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Fin Pestaña Inventario-->

                        <!-- Pestaña Eventos -->
                        <div id="tabEvento" class="tab-pane fade in">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabEventos1" runat="server">
                                        <br />
                                        <div class="well well-sm shadow1">
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Fin Pestaña eventos-->
                        <!-- Pestaña Eventos -->
                        <div id="tabEstudiante" class="tab-pane fade in">
                            <asp:UpdatePanel runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabEstudiante1" runat="server">
                                        <br />
                                        <div class="well well-sm shadow1">
                                        </div>
                                        <div class="well well-sm shadow1">
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Fin Pestaña eventos-->
                    </div>
                    <!-- Fin Contenido Pestañas -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
