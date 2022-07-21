<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Mantenimiento.aspx.cs" Inherits="slnCAI.Mantenimiento" %>

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
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:HiddenField ID="hfTab" runat="server" Value="" />
    <div class="container-fluid">
        <asp:Literal ID="ltlMessage" runat="server" Visible="False"></asp:Literal>
        <div runat="server" id="MantenimientoPage">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <asp:Localize ID="eventos1" runat="server" Text="<%$Resources:mantenimiento.language, mantenimiento%>"></asp:Localize>
                </div>
                <div class="panel-body">
                    <!-- Menu de Pestañas - Inicio  -tabs1-->
                    <ul class="nav nav-tabs nav-justified" id="myTabs">
                        <asp:Literal ID="ltlTabs" runat="server"></asp:Literal>
                    </ul>
                    <!-- Menu de Pestañas - Fin -->

                    <!-- Contenido de Pestañas - Inicio -->
                    <div class="tab-content">
                        <!-- Pestaña Mantenimiento de Puestos - Inicio -->
                        <div id="tabPuesto" class="tab-pane fade in">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabPuesto1" runat="server">
                                        <asp:Literal ID="ltlMsg_Puesto" runat="server"></asp:Literal>
                                        <div class="row">
                                                <!-- Columna 1 - Column 1 -->
                                                <div class="form-group">
                                                    <!--<label>ID:</label> -->
                                                    <asp:TextBox ID="txtId_Pst" runat="server" CssClass="form-control input-sm" Enabled="False" Visible="false"></asp:TextBox>
                                                </div>
                                            <div class="col-sm-4">
                                                <!-- Columna 2 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize8" runat="server" Text="<%$Resources:mantenimiento.language, puesto2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtPuesto_Pst" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <!-- Columna 3 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize9" runat="server" Text="<%$Resources:mantenimiento.language, observaciones2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObserv_Pst" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <!-- Columna 4 -->
                                                <div class="form-group">
                                                    <label style="color: white;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Pst" runat="server" Text="<%$Resources:mantenimiento.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btnGuardar_Pst_Click" />
                                                    <asp:Button ID="btnCancelar_Pst" runat="server" Text="<%$Resources:mantenimiento.language, cancelar%>" CssClass="btn btn-warning btn-sm" OnClick="btnCancelar_Pst_Click" />
                                                    <asp:Button ID="btnEliminar_Pst" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-sm" OnClick="btnEliminar_Pst_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 3 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvPuesto_Pst" DataKeyNames="idPuesto" runat="server" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" OnRowCommand="grvPuesto_Pst_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="ID" DataField="idPuesto" Visible="false"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:mantenimiento.language, puesto%>" DataField="puesto"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:mantenimiento.language, observaciones%>" DataField="observaciones"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                        <!-- Pestaña Mantenimiento de Puestos - Fin -->

                        <!-- Pestaña Mantenimiento de Tipo Equipo - Inicio -->
                        <div id="tabTipoEquipo" class="tab-pane fade">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabTipoEquipo1" runat="server">
                                        <asp:Literal ID="ltlMsg_TpEquipo" runat="server"></asp:Literal>
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div>
                                                <!-- Columna 1 -->
                                                <div class="form-group">
                                                    <asp:TextBox ID="txtIdTpE_TpE" runat="server" CssClass="form-control input-sm" Enabled="False" Visible="false"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <!-- Columna 2 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize10" runat="server" Text="<%$Resources:mantenimiento.language, tipoequipo2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtTpEquipo_TpE" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <!-- Columna 3 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize11" runat="server" Text="<%$Resources:mantenimiento.language, observaciones2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObserv_TpE" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: white;">.</label><br />
                                                    <asp:Button ID="btnGuardar_TpE" runat="server" Text="<%$Resources:mantenimiento.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btnGuardar_TpE_Click" />
                                                    <asp:Button ID="btnCancelar_TpE" runat="server" Text="<%$Resources:mantenimiento.language, cancelar%>" CssClass="btn btn-warning btn-sm" OnClick="btnCancelar_TpE_Click" />
                                                    <asp:Button ID="btnEliminar_TpE" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-sm" OnClick="btnEliminar_TpE_Click" />
                                                </div>
                                            </div>

                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 3 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvTipoEquipo_TpE" DataKeyNames="idTipoEquipo" runat="server" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" ShowHeader="true" AutoGenerateColumns="False" OnRowCommand="grvTipoEquipo_TpE_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="ID" DataField="idTipoEquipo" Visible="false"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:mantenimiento.language, tipoequipo%>" DataField="tipoEquipo"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:mantenimiento.language, observaciones%>" DataField="observaciones"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar2" runat="server" CommandName="Modificar2" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                        <!-- Pestaña Mantenimiento de Tipo Equipo - Fin -->

                        <!-- Pestaña Mantenimiento de Equipo - Inicio -->
                        <div id="tabEquipo" class="tab-pane fade">
                            <br />
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabEquipo1" runat="server">
                                        <asp:Literal ID="ltlMsg_Equipo" runat="server"></asp:Literal>
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize12" runat="server" Text="<%$Resources:mantenimiento.language, codigo2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtCodigo_Eqp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize13" runat="server" Text="<%$Resources:mantenimiento.language, placa2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtPlaca_Eqp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize14" runat="server" Text="<%$Resources:mantenimiento.language, serie2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtSerie_Eqp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize15" runat="server" Text="<%$Resources:mantenimiento.language, estado2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEstado_Eqp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize16" runat="server" Text="<%$Resources:mantenimiento.language, marcas2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlMarca_Eqp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize17" runat="server" Text="<%$Resources:mantenimiento.language, modelo2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtModelo_Eqp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize18" runat="server" Text="<%$Resources:mantenimiento.language, descripcion%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtDescrip_Eqp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize19" runat="server" Text="<%$Resources:mantenimiento.language, tipoequipo2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlTipoEquipo_Eqp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 3 -->
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize20" runat="server" Text="<%$Resources:mantenimiento.language, costoaproximado%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtCosto_Eqp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize21" runat="server" Text="<%$Resources:mantenimiento.language, espacios2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEspacio_Eqp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize22" runat="server" Text="<%$Resources:mantenimiento.language, encargado%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEncargado_Eqp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize23" runat="server" Text="<%$Resources:mantenimiento.language, condicion2%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlCondicion_Eqp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 4 -->
                                            <div class="col-sm-9">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize24" runat="server" Text="<%$Resources:mantenimiento.language, observaciones2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObserv_Eqp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: white;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Eqp" runat="server" Text="<%$Resources:mantenimiento.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btnGuardar_Eqp_Click" />
                                                    <asp:Button ID="btnCancelar_Eqp" runat="server" Text="<%$Resources:mantenimiento.language, cancelar%>" CssClass="btn btn-warning btn-sm" OnClick="btnCancelar_Eqp_Click" />
                                                    <asp:Button ID="btnEliminar_Eqp" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-sm" OnClick="btnEliminar_Eqp_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 5 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvEquipo_Eqp" runat="server" CssClass="table table-striped table-bordered table-hover" AutoGenerateColumns="False" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" ShowHeader="true" OnRowCommand="grvEquipo_Eqp_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField DataField="idEquipo" HeaderText="<%$Resources:mantenimiento.language, codigo%>"></asp:BoundField>
                                                            <asp:BoundField DataField="marca" HeaderText="<%$Resources:mantenimiento.language, marcas%>"></asp:BoundField>
                                                            <asp:BoundField DataField="modelo" HeaderText="<%$Resources:mantenimiento.language, modelo%>"></asp:BoundField>
                                                            <asp:BoundField DataField="descripcion" HeaderText="<%$Resources:mantenimiento.language, descripcion%>"></asp:BoundField>
                                                            <asp:BoundField DataField="idTipoEquipo" HeaderText="idTipoEquipo" Visible="false"></asp:BoundField>
                                                            <asp:BoundField DataField="tipoEquipo" HeaderText="<%$Resources:mantenimiento.language, tipoequipo%>"></asp:BoundField>
                                                            <asp:BoundField DataField="Espacio" HeaderText="<%$Resources:mantenimiento.language, espacios%>"></asp:BoundField>
                                                            <asp:BoundField DataField="nombre_Completo" HeaderText="<%$Resources:mantenimiento.language, encargado%>"></asp:BoundField>
                                                            <asp:BoundField DataField="condicion" HeaderText="<%$Resources:mantenimiento.language, condicion%>"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>

                                                        </Columns>
                                                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                        <!-- Pestaña Mantenimiento de Equipo - Fin -->

                        <!-- Pestaña Mantenimiento de Espacio - Inicio -->
                        <div id="tabEspacio" class="tab-pane fade">
                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabEspacio1" runat="server">
                                        <asp:Literal ID="ltlMsg_Espacios" runat="server"></asp:Literal>
                                        <div class="row">
                                            <div class="col-sm-9">
                                                <div class="row">
                                                    <!-- Fila 1 -->
                                                    <div>
                                                        <div class="form-group">
                                                            <!--<label><asp:Localize ID ="Localize25" runat ="server" Text="<%$Resources:mantenimiento.language, codigo2%>"></asp:Localize></label>-->
                                                            <asp:TextBox ID="txtCodigo_Esp" runat="server" CssClass="form-control input-sm" Visible="false"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label>
                                                                <asp:Localize ID="Localize26" runat="server" Text="<%$Resources:mantenimiento.language, espacios2%>"></asp:Localize></label>
                                                            <asp:TextBox ID="txtEspacio_Esp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label>
                                                                <asp:Localize ID="Localize27" runat="server" Text="<%$Resources:mantenimiento.language, ubication2%>"></asp:Localize></label>
                                                            <asp:TextBox ID="txtUbicacion_Esp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label>
                                                                <asp:Localize ID="Localize28" runat="server" Text="<%$Resources:mantenimiento.language, encargado%>"></asp:Localize></label>
                                                            <asp:DropDownList ID="ddlEncargado_Esp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <!-- Fila 2 -->
                                                    <div class="col-sm-12">
                                                        <div class="row">
                                                            <div class="col-sm-3">
                                                                <div class="form-group">
                                                                    <label>
                                                                        <asp:Localize ID="Localize29" runat="server" Text="<%$Resources:mantenimiento.language, cantidadequipos2%>"></asp:Localize></label>
                                                                    <asp:TextBox ID="txtCantidad_Esp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-3">
                                                                <div class="form-group">
                                                                    <label>
                                                                        <asp:Localize ID="Localize30" runat="server" Text="<%$Resources:mantenimiento.language, tipoequipo2%>"></asp:Localize></label>
                                                                    <asp:DropDownList ID="ddlTipoEqp_Esp" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-4">
                                                                <div class="form-group">
                                                                    <label>
                                                                        <asp:Localize ID="Localize31" runat="server" Text="<%$Resources:mantenimiento.language, observaciones2%>"></asp:Localize></label>
                                                                    <asp:TextBox ID="txtObserv_Esp" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                                </div>
                                                            </div>
                                                            <div class="col-sm-2 text-center">
                                                                <div class="form-group">
                                                                    <label style="color: white;">.</label><br />
                                                                    <div class="btn-group">
                                                                        <asp:Button ID="btnAgregar_Esp" runat="server" Text="<%$Resources:mantenimiento.language, agregar%>" CssClass="btn btn-default btn-xs" OnClick="btnAgregar_Esp_Click" />
                                                                        <asp:Button ID="btnEliminarTp_esp" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-xs" Visible="false" OnClick="btnEliminarTp_esp_Click" />
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <label>
                                                    <asp:Localize ID="Localize32" runat="server" Text="<%$Resources:mantenimiento.language, listadeequipos%>"></asp:Localize></label>
                                                <asp:ListBox ID="lstEquipos_Esp" runat="server" CssClass="form-control" Rows="6" OnSelectedIndexChanged="lstEquipos_Esp_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 3 -->
                                            <div class="col-sm-9"></div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: white;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Esp" runat="server" Text="<%$Resources:mantenimiento.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btnGuardar_Esp_Click" />
                                                    <asp:Button ID="btnCancelar_Esp" runat="server" Text="<%$Resources:mantenimiento.language, cancelar%>" CssClass="btn btn-warning btn-sm" OnClick="btnCancelar_Esp_Click" />
                                                    <asp:Button ID="btnEliminar_Esp" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-sm" OnClick="btnEliminar_Esp_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 4 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvEspacios_Esp" DataKeyNames="idEspacio" runat="server" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" ShowHeader="true" AutoGenerateColumns="False" OnRowCommand="grvEspacios_Esp_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField DataField="idEspacio" HeaderText="<%$Resources:mantenimiento.language, codigo%>" Visible="false"></asp:BoundField>
                                                            <asp:BoundField DataField="Espacio" HeaderText="<%$Resources:mantenimiento.language, espacios%>"></asp:BoundField>
                                                            <asp:BoundField DataField="ubicacion" HeaderText="<%$Resources:mantenimiento.language, ubication%>"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                        <!-- Pestaña Mantenimiento de Espacio - Fin -->

                        <!-- Pestaña Mantenimiento de Instituciones - Inicio -->
                        <div id="tabInstituciones" class="tab-pane fade">
                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabInstituciones1" runat="server">
                                        <asp:Literal ID="ltlMsg_Ins" runat="server"></asp:Literal>
                                        <div class="row">
                                            <div>
                                                <div class="form-group">
                                                    <asp:TextBox ID="txtId_Ins" runat="server" CssClass="form-control input-sm" Enabled="False" Visible="false"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize33" runat="server" Text="<%$Resources:mantenimiento.language, instituciones2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtInst_Ins" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize34" runat="server" Text="<%$Resources:mantenimiento.language, observaciones2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObserv_Ins" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: white;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Ins" runat="server" Text="<%$Resources:mantenimiento.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btnGuardar_Ins_Click" />
                                                    <asp:Button ID="btnCancelar_Ins" runat="server" Text="<%$Resources:mantenimiento.language, cancelar%>" CssClass="btn btn-warning btn-sm" OnClick="btnCancelar_Ins_Click" />
                                                    <asp:Button ID="btnEliminar_Ins" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-sm" OnClick="btnEliminar_Ins_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvInstituciones_Ins" DataKeyNames="idInstitucion" runat="server" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" ShowHeader="true" OnRowCommand="grvInstitucion_Ins_RowCommand" AutoGenerateColumns="false">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="ID" DataField="idInstitucion" Visible="false"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:mantenimiento.language, instituciones%>" DataField="nombre_institucion"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:mantenimiento.language, observaciones%>" DataField="observaciones"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar3" runat="server" CommandName="Modificar3" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                        <!-- Pestaña Mantenimiento de Instituciones - Fin -->

                        <!-- Pestaña Mantenimiento de Marcas - Inicio -->
                        <div id="tabMarcas" class="tab-pane fade">
                            <asp:UpdatePanel ID="UpdatePanel6" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabMarcas1" runat="server">
                                        <asp:Literal ID="ltlMsg_Marcas" runat="server"></asp:Literal>
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div>
                                                <div class="form-group">
                                                    <asp:TextBox ID="txtId_Mrc" runat="server" CssClass="form-control input-sm" Enabled="False" Visible="false"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize35" runat="server" Text="<%$Resources:mantenimiento.language, marcas2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtMarca_Mrc" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize36" runat="server" Text="<%$Resources:mantenimiento.language, observaciones2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObserv_Mrc" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: white;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Mrc" runat="server" Text="<%$Resources:mantenimiento.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btnGuardar_Mrc_Click" />
                                                    <asp:Button ID="btnCancelar_Mrc" runat="server" Text="<%$Resources:mantenimiento.language, cancelar%>" CssClass="btn btn-warning btn-sm" OnClick="btnCancelar_Mrc_Click" />
                                                    <asp:Button ID="btnEliminar_Mrc" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-sm" OnClick="btnEliminar_Mrc_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvMarcas_Mrc" DataKeyNames="idMarca" AutoGenerateColumns="False" runat="server" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" ShowHeader="true" OnRowCommand="grvMarca_Mrc_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField DataField="idMarca" HeaderText="ID" Visible="false"></asp:BoundField>
                                                            <asp:BoundField DataField="marca" HeaderText="<%$Resources:mantenimiento.language, marcas%>"></asp:BoundField>
                                                            <asp:BoundField DataField="observaciones" HeaderText="<%$Resources:mantenimiento.language, observaciones%>"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                        <!-- Pestaña Mantenimiento de Marcas - Fin -->

                        <!-- Pestaña Mantenimiento de Condición - Inicio -->
                        <div id="tabCondicion" class="tab-pane fade">
                            <asp:UpdatePanel ID="UpdatePanel7" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabCondicion1" runat="server">
                                        <asp:Literal ID="ltlMsg_Condicion" runat="server"></asp:Literal>
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div>
                                                <!-- Columna 1 -->
                                                <div class="form-group">
                                                    <asp:TextBox ID="txtId_Cnd" runat="server" CssClass="form-control input-sm" Enabled="False" Visible="false"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <!-- Columna 2 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize37" runat="server" Text="<%$Resources:mantenimiento.language, condicion2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtCondicion_Cnd" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-5">
                                                <!-- Columna 3 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize38" runat="server" Text="<%$Resources:mantenimiento.language, observaciones2%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObservaciones_Cnd" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group">
                                                    <label style="color: white;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Cnd" runat="server" Text="<%$Resources:mantenimiento.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btnGuardar_Cnd_Click" />
                                                    <asp:Button ID="btnCancelar_Cnd" runat="server" Text="<%$Resources:mantenimiento.language, cancelar%>" CssClass="btn btn-warning btn-sm" OnClick="btnCancelar_Cnd_Click" />
                                                    <asp:Button ID="btnEliminar_Cnd" runat="server" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-sm" OnClick="btnEliminar_Cnd_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvCondicion_Cnd" DataKeyNames="idCondicion" AutoGenerateColumns="False" runat="server" CssClass="table table-striped table-bordered table-hover" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" ShowHeader="true" OnRowCommand="grvCondicion_Cnd_RowCommand">
                                                        <Columns>
                                                            <asp:BoundField DataField="idCondicion" HeaderText="ID" Visible="false"></asp:BoundField>
                                                            <asp:BoundField DataField="condicion" HeaderText="<%$Resources:mantenimiento.language, condicion%>"></asp:BoundField>
                                                            <asp:BoundField DataField="descripcion" HeaderText="<%$Resources:mantenimiento.language, observaciones%>"></asp:BoundField>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                        <!-- Pestaña Mantenimiento de Condición - Final -->

                    </div>
                    <!-- Contenido de Pestañas - Fin -->
                </div>
            </div>
        </div>
    </div>
</asp:Content>
