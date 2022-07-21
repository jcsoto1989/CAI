<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Seguridad.aspx.cs" Inherits="slnCAI.Seguridad" %>

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

    </script>

    <style>
        .GridPager a,
        .GridPager span {
            display: inline-block;
            padding: 0px 9px;
            margin-right: 4px;
            border-radius: 3px;
            border: solid 1px #c0c0c0;
            background: #e9e9e9;
            box-shadow: inset 0px 1px 0px rgba(255,255,255, .8), 0px 1px 3px rgba(0,0,0, .1);
            font-size: .875em;
            font-weight: bold;
            text-decoration: none;
            color: #717171;
            text-shadow: 0px 1px 0px rgba(255,255,255, 1);
        }

        .GridPager a {
            background-color: #f5f5f5;
            color: #969696;
            border: 1px solid #969696;
        }

        .GridPager span {
            background: #616161;
            box-shadow: inset 0px 0px 8px rgba(0,0,0, .5), 0px 1px 0px rgba(255,255,255, .8);
            color: #f0f0f0;
            text-shadow: 0px 0px 3px rgba(0,0,0, .5);
            border: 1px solid #3AC0F2;
        }


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
            -webkit-box-shadow: 2px 2px 0px 0px #bbb; /* Safari 3-4, iOS 4.0.2 - 4.2, Android 2.3+ */
            -moz-box-shadow: 2px 2px 0px 0px #bbb; /* Firefox 3.5 - 3.6 */
            box-shadow: 2px 2px 0px 0px #bbb; /* Opera 10.5, IE 9, Firefox 4+, Chrome 6+, iOS 5 */
            /*[horizontal offset] [vertical offset] [blur radius] [optional spread radius] [color];*/
            border: 1px solid #ddd;
        }

        .chkboxlist td {
            padding-right: 10px;
        }


        input[type='checkbox'] {
            -webkit-appearance: none;
            width: 15px;
            height: 15px;
            border-radius: 2px;
            background-color: #969696;
            box-shadow: #000 1px 1px 4px 1px inset;
        }
            input[type='checkbox']:hover {
                cursor: pointer;
                background: url('Imagenes/check.png');
            }

            input[type='checkbox']:checked {
                /*background: #01004e; stay transparent, even after checked */
                background: url('Imagenes/check1.png');
                background-color: #136f01;
                padding: 1px;
                /*display: block;*/
            }

                input[type='checkbox']:checked:hover {
                    background-color: #969696;
                }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfTab" runat="server" Value="tabUsuarios" />
    <div class="container-fluid">

        <asp:Literal ID="ltlMessage" runat="server" Visible="False"></asp:Literal>
        <div id="SeguridadPage" runat="server">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <asp:Localize ID="eventos1" runat="server" Text="<%$Resources:seguridad.language, seguridad%>"></asp:Localize>
                </div>
                <div class="panel-body">
                    <!-- Menu de Pestañas - Inicio -->
                    <ul class="nav nav-tabs nav-justified" id="myTabs">
                        <asp:Literal ID="ltlTabs" runat="server"></asp:Literal>
                    </ul>
                    <!-- Menu de Pestañas - Fin -->

                    <!-- Pestañas - Inicio -->
                    <div class="tab-content">
                        <!-- Pestaña Usuarios - Inicio -->
                        <div id="tabUsuarios" class="tab-pane fade in">
                            <div class="container-fluid shadow" id="tabUsuarios1" runat="server">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_Usuarios" runat="server"></asp:Literal>
                                        <br />
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div class="col-sm-6">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize4" runat="server" Text="<%$Resources:seguridad.language, nombrecompleto2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlColaborador" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize6" runat="server" Text="<%$Resources:seguridad.language, usuarios2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtUser_User" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize7" runat="server" Text="<%$Resources:seguridad.language, pass%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtPass_User" TextMode="Password" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize8" runat="server" Text="<%$Resources:seguridad.language, rol2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlRol_User" runat="server" CssClass="form-control input-sm">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-6"></div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: #fff;">.</label><br />
                                                    <asp:Button ID="btnGuardar_User" runat="server" Text="<%$Resources:seguridad.language, guardar%>" CssClass="btn btn-primary btn-sm"
                                                        OnClick="btnGuardar_User_Click" />
                                                    <asp:Button ID="btnCancelar_User" runat="server" Text="<%$Resources:seguridad.language, cancelar%>" CssClass="btn btn-warning btn-sm"
                                                        OnClick="btnCancelar_User_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 3 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvUser_User" runat="server" DataKeyNames="numero_Identificacion, idRol_Usuario" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" OnRowCommand="grvUsuario_User_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="<%$Resources:seguridad.language, nombrecompleto%>" DataField="nombre_Completo"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:seguridad.language, usuarios%>" DataField="usuario"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:seguridad.language, rol%>" DataField="rol"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:seguridad.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                    <asp:Button ID="btnEliminar1" runat="server" CommandName="Eliminar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:seguridad.language, eliminar%>" CssClass="btn btn-danger btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <!-- Pestaña Usuarios - Final -->

                        <!-- Pestaña Roles - Inicio -->
                        <div id="tabRoles" class="tab-pane fade in">
                            <div class="container-fluid shadow" id="tabRoles1" runat="server">
                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_Roles" runat="server"></asp:Literal>
                                        <br />
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div>
                                                <div class="form-group">
                                                    <asp:TextBox ID="txtId_Rol" runat="server" CssClass="form-control input-sm" Enabled="False" Visible="false"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize10" runat="server" Text="<%$Resources:seguridad.language, rol2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtRol_Rol" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize11" runat="server" Text="<%$Resources:seguridad.language, descripcion2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtDescri_Rol" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: #fff;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Rol" runat="server" Text="<%$Resources:seguridad.language, guardar%>" CssClass="btn btn-primary btn-sm"
                                                        OnClick="btnGuardar_Rol_Click" />
                                                    <asp:Button ID="btnCancelar_Rol" runat="server" Text="<%$Resources:seguridad.language, cancelar%>" CssClass="btn btn-warning btn-sm"
                                                        OnClick="btnCancelar_Rol_Click" />
                                                    <asp:Button ID="btnEliminar_Rol" runat="server" Text="<%$Resources:seguridad.language, eliminar%>" CssClass="btn btn-danger btn-sm"
                                                        OnClick="btnEliminar_Rol_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvRoles_Rol" DataKeyNames="idRol" runat="server" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" OnRowCommand="grvUsuario_Rol_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="<%$Resources:seguridad.language, rol%>" DataField="rol"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:seguridad.language, descripcion%>" DataField="descripcion"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar" runat="server" CommandName="Modificarp" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:seguridad.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                        <!-- Pestaña Roles - Final -->

                        <!-- Pestaña Permisos - Inicio -->
                        <div id="tabPermisos" class="tab-pane fade in">
                            <div class="container-fluid shadow" id="tabPermisos1" runat="server">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_Permisos" runat="server"></asp:Literal>
                                        <br />
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize12" runat="server" Text="<%$Resources:seguridad.language, rol2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlRol_Perm" runat="server" CssClass="form-control input-sm" AutoPostBack="True" OnSelectedIndexChanged="ddlRol_Perm_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-9">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize17" runat="server" Text="<%$Resources:seguridad.language, principal%>"></asp:Localize></label>
                                                    <asp:CheckBoxList ID="chkMenuPrincipal_Perm" runat="server" CssClass="form-control chkboxlist" RepeatDirection="Horizontal" RepeatColumns="8" Height="100%" ForeColor="Black">
                                                    </asp:CheckBoxList>
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize13" runat="server" Text="<%$Resources:seguridad.language, paginaiac%>"></asp:Localize></label>
                                                    <asp:CheckBoxList ID="chkIAC_Perm" runat="server" CssClass="form-control" RepeatDirection="Horizontal" RepeatColumns="1" Height="100%" OnSelectedIndexChanged="chkIAC_Perm_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:CheckBoxList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize14" runat="server" Text="<%$Resources:seguridad.language, paginaman%>"></asp:Localize></label>
                                                    <asp:CheckBoxList ID="chkManteni_Perm" runat="server" CssClass="form-control" RepeatDirection="Horizontal" RepeatColumns="1" Height="100%" OnSelectedIndexChanged="chkManteni_Perm_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:CheckBoxList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <label>
                                                    <asp:Localize ID="Localize15" runat="server" Text="<%$Resources:seguridad.language, paginapro%>"></asp:Localize></label>
                                                <asp:CheckBoxList ID="chkProceso_Perm" runat="server" CssClass="form-control" RepeatDirection="Horizontal" RepeatColumns="1" Height="100%" OnSelectedIndexChanged="chkProceso_Perm_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize16" runat="server" Text="<%$Resources:seguridad.language, paginaseg%>"></asp:Localize></label>
                                                    <asp:CheckBoxList ID="chkSeguridad_Perm" runat="server" CssClass="form-control" RepeatDirection="Horizontal" RepeatColumns="1" Height="100%" OnSelectedIndexChanged="chkSeguridad_Perm_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:CheckBoxList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-9">
                                                <label>
                                                    <asp:Localize ID="Localize1" runat="server" Text="<%$Resources:seguridad.language, reportes%>"></asp:Localize></label>
                                                <asp:CheckBoxList ID="chkReporte_Perm" runat="server" CssClass="form-control chkboxlist" RepeatDirection="Horizontal" RepeatColumns="7" Height="100%" OnSelectedIndexChanged="chkReporte_Perm_SelectedIndexChanged" AutoPostBack="true">
                                                </asp:CheckBoxList>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: #fff;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Perm" runat="server" Text="<%$Resources:seguridad.language, guardar%>" CssClass="btn btn-primary btn-sm"
                                                        OnClick="btnGuardar_Perm_Click" OnClientClick="abrirventana();" />
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <!-- Pestaña Permisos - Final -->

                        <!-- Pestaña Bitacora - Inicio -->
                        <div id="tabBitacora" class="tab-pane fade in">
                            <div class="container-fluid shadow1" id="tabBitacora1" runat="server">
                                <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_Bitacora" runat="server"></asp:Literal>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:Literal ID="ltlBitacora" runat="server"></asp:Literal>
                                                    <script>
                                                        $(document).ready(function () {
                                                            $('#tblBitacora').DataTable({
                                                                dom: 'Bfrtip',
                                                                "language": { "url": "https://cdn.datatables.net/plug-ins/1.10.19/i18n/Spanish.json" },
                                                                lengthMenu: [[10, 25, 50, -1], ['10 rows', '25 rows', '50 rows', 'Show all']
                                                                ],
                                                                buttons: ['pageLength', {
                                                                    extend: 'pdfHtml5',
                                                                    orientation: 'landscape',
                                                                    pageSize: 'LETTER',
                                                                    title: 'Reporte'
                                                                },
                                                                {
                                                                    extend: 'print',
                                                                    autoPrint: true,
                                                                }, 'copyHtml5', 'excelHtml5']
                                                            });
                                                        });
                                                    </script>
                                                </div>
                                            </div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <!-- Pestaña Bitacora - Final -->

                        <!-- Pestaña BackUp - Inicio -->
                        <div id="tabBackup" class="tab-pane fade in">
                            <div class="container-fluid shadow1" id="tabBackup1" runat="server">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_Backup" runat="server"></asp:Literal>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-6">
                                                <asp:Button ID="btnCrearBackup" runat="server" Text="<%$Resources:seguridad.language, respaldar%>" CssClass="btn btn-primary btn-block" OnClick="btnCrearBackup_Click" />
                                            </div>
                                            <div class="col-sm-3"></div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-4">
                                                <asp:FileUpload ID="flpBackupUpload" accept=".iac" runat="server" CssClass="form-control input-sm" />
                                            </div>
                                            <div class="col-sm-2">
                                                <asp:Button runat="server" ID="btnUploadBackup" Text="<%$Resources:seguridad.language, subir%>" CssClass="btn btn-block btn-default btn-sm" OnClick="btnUploadBackup_Click" />
                                            </div>
                                            <div class="col-sm-3"></div>

                                        </div>
                                        <hr />
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:seguridad.language, listaRespaldo%>"></asp:Label>
                                                    <asp:ListBox ID="lstBackups" CssClass="form-control" Height="100%" runat="server"></asp:ListBox>
                                                </div>
                                                <asp:UpdateProgress ID="UpdateProgressRestore" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                    <ProgressTemplate>
                                                        <div class="text-center" style="width: 100%;">
                                                            <img src="Imagenes/ajax-loader.gif" />&nbsp;<asp:Label runat="server" Text="<%$Resources:seguridad.language, espere%>"></asp:Label>
                                                        </div>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </div>
                                            <div class="col-sm-3"></div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-2">
                                                <asp:Button ID="btnResturar_Rest" CssClass="btn btn-primary btn-block" runat="server" Text="<%$Resources:seguridad.language, restaurar%>" OnClick="btnResturar_Rest_Click" />
                                            </div>
                                            <div class="col-sm-2">
                                                <asp:Button ID="btnEliminar_Rest" CssClass="btn btn-danger btn-block" runat="server" Text="<%$Resources:seguridad.language, eliminar%>" OnClick="btnEliminar_Rest_Click" />
                                            </div>
                                            <div class="col-sm-2">
                                                <asp:Button ID="btnDescargarRespaldo" CssClass="btn btn-default btn-block" runat="server" Text="<%$Resources:seguridad.language, descargar%>" OnClick="btnDescargarRespaldo_Click" />
                                            </div>
                                            <div class="col-sm-3"></div>
                                        </div>
                                        <br />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnDescargarRespaldo" />
                                        <asp:PostBackTrigger ControlID="btnUploadBackup" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                        <!-- Pestaña Bitacora - Final -->

                    </div>
                    <!-- Pestañas - Final -->
                </div>
            </div>

        </div>
    </div>
</asp:Content>
