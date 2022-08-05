<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Procesos.aspx.cs" Inherits="slnCAI.Procesos" Culture="es-CR" UICulture="es-CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">

        $(document).ready(function () {
            var selectedTab = $("#<%=hfTab.ClientID%>");
            var tabId = selectedTab.val() != "" ? selectedTab.val() : "tabEventos";
            $('#myTabs a[href="#' + tabId + '"]').tab('show');
            $("#myTabs a").click(function () {
                selectedTab.val($(this).attr("href").substring(1));
            });
        });

        jQuery(document).ready(function ($) {

            // Javascript to enable link to tab
            var url = document.location.toString();
            if (url.match('#')) {
                $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
            }

            // Change hash for page-reload
            $('.nav-tabs a').on('shown.bs.tab', function (e) {
                window.location.hash = e.target.hash;
            });
        });

        $('#myTabs a').click(function (e) {
            e.preventDefault();
            $(this).tab('show');
        });

        function openModal() {
            $('#nuevoEvento').modal('show');
        }

        function openModalExcel() {
            $('#MdlInscripcionExcel').modal('show');
        }

        function Search_Gridview(strKey, grid) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById(grid);
            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }

    </script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            document.querySelectorAll('input[type=text]').forEach(node => node.addEventListener('keypress', e => {
                if (e.keyCode == 13) {
                    e.preventDefault();
                }
            }))
        });
</script>

    <style>
        .custom-file-input {
            border-bottom: 1px solid black;
            padding: 5px;
            width: 90%;
            text-align: center;
        }

            .custom-file-input::-webkit-file-upload-button {
                visibility: hidden;
            }

            .custom-file-input::before {
                content: 'Seleccione un Archivo';
                display: inline-block;
                background-color: #337ab7;
                border: 1px solid #337ab7;
                border-radius: 10px;
                padding: 5px 10px;
                outline: none;
                white-space: nowrap;
                -webkit-user-select: none;
                cursor: pointer;
                font-weight: bold;
                color: #fff;
                font-size: 8pt;
            }

            .custom-file-input:hover::before {
                border-color: black;
                background-color: #000066;
            }

            .custom-file-input:active::before {
                background: -webkit-linear-gradient(top, #e3e3e3, #f9f9f9);
                background-color: #000066;
            }



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
            padding-right: 5px;
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
    <asp:HiddenField ID="hfTab" runat="server" Value="tabEventos" />
    <asp:HiddenField ID="hfTipoPersona" runat="server" Value="2" />
    <div class="container-fluid">
        <div id="ProcesosPage" runat="server">
            <div class="panel panel-primary">
                <asp:Literal ID="ltlMessage" runat="server" Visible="false"></asp:Literal>
                <div class="panel-heading">
                    <asp:Localize ID="Localize1" runat="server" Text="<%$Resources:procesos.language, evento%>"></asp:Localize>
                </div>
                <div class="panel-body">
                    <!-- Menu de Pestañas - Inicio -->
                    <ul class="nav nav-tabs nav-justified" id="myTabs">
                        <asp:Literal ID="ltlTabs" runat="server"></asp:Literal>
                    </ul>
                    <!-- Menu de Pestañas - Fin -->

                    <!-- Pestañas - Inicio -->
                    <div class="tab-content">
                        <!-- Pestaña Evento - Espacio - Inicio -->
                        <div id="tabEventos" class="tab-pane fade in">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabEventos1" runat="server">
                                        <asp:Literal ID="ltlMsg_Eventos" runat="server"></asp:Literal>
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div>
                                                <!-- Columna 1 -->
                                                <div class="form-group">
                                                    <asp:TextBox ID="txtId_Evt" runat="server" CssClass="form-control input-sm" Visible="false" Enabled="false"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <!-- Columna 2 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize11" runat="server" Text="<%$Resources:procesos.language, evento%>"></asp:Localize></label>
                                                    <div class="input-group">
                                                        <asp:DropDownList ID="ddlEvento_Evt" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlEvento_Evt_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                        <div class="input-group-btn">
                                                            <button class="btn btn-default btn-sm" type="button" data-toggle="modal" data-target="#nuevoEvento">
                                                                <i class="glyphicon glyphicon-plus"></i>
                                                            </button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <!-- Columna 3 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize12" runat="server" Text="<%$Resources:procesos.language, periodo%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlPeriodo_Evt" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlPeriodo_Evt_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <!-- Columna 4 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize8" runat="server" Text="<%$Resources:procesos.language, tipoId%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlTipoIdentificacion_Evento" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlTipoIdentificacion_SelectedIndexChanged" AutoPostBack="true">
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <!-- Columna 4 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize7" runat="server" Text="<%$Resources:procesos.language, id%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtIdEncargado" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtIdEncargado" Mask="9-9999-9999" />
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <!-- Columna 4 -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize13" runat="server" Text="<%$Resources:procesos.language, fechaInicio%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtFechaInicio_Evt" TextMode="Date" runat="server" CssClass="form-control input-sm" OnTextChanged="txtFechaInicio_Evt_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <!-- Fecha Final -->
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize2" runat="server" Text="<%$Resources:procesos.language, fechaFinal%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtFechaFinal_Evt" TextMode="Date" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <!-- Hora Inicio -->
                                            <div class="col-sm-2" style="width: 12%">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize3" runat="server" Text="<%$Resources:procesos.language, horaInicio%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtHoraInicio" TextMode="Time" runat="server" CssClass="form-control input-sm" OnTextChanged="txtHoraInicio_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <!-- Hora Final -->
                                            <div class="col-sm-2" style="width: 12%">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize4" runat="server" Text="<%$Resources:procesos.language, horafinal%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtHoraFinal" TextMode="Time" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <!-- Dias -->
                                            <div class="col-sm-3" style="width: 26%">
                                                <label>
                                                    <asp:Localize ID="Localize5" runat="server" Text="<%$Resources:procesos.language, dia%>"></asp:Localize></label>
                                                <asp:CheckBoxList ID="chkDias" runat="server" RepeatDirection="Horizontal" RepeatColumns="7" CssClass="form-control chkboxlist input-sm">
                                                    <asp:ListItem Text="<%$Resources:procesos.language, lunes%>" Value="1"></asp:ListItem>
                                                    <asp:ListItem Text="<%$Resources:procesos.language, martes%>" Value="2"></asp:ListItem>
                                                    <asp:ListItem Text="<%$Resources:procesos.language, miercoles%>" Value="3"></asp:ListItem>
                                                    <asp:ListItem Text="<%$Resources:procesos.language, jueves%>" Value="4"></asp:ListItem>
                                                    <asp:ListItem Text="<%$Resources:procesos.language, viernes%>" Value="5"></asp:ListItem>
                                                    <asp:ListItem Text="<%$Resources:procesos.language, sabado%>" Value="6"></asp:ListItem>
                                                    <asp:ListItem Text="<%$Resources:procesos.language, domingo%>" Value="0"></asp:ListItem>
                                                </asp:CheckBoxList>
                                            </div>
                                            <!-- Espacio -->
                                            <div class="col-sm-2">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize6" runat="server" Text="<%$Resources:procesos.language, espacio%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEspacio" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize51" runat="server" Text="<%$Resources:procesos.language, espacio%>"></asp:Localize></label>
                                                    <asp:CheckBox runat="server" Text="Activar" ID="chkControlPC_Evento" CssClass="form-control input-sm" />
                                                </div>
                                            </div>
                                            <!-- Agregar Fechas -->
                                            <div class="col-sm-2">
                                                <!-- Columna 5 -->
                                                <div class="form-group">
                                                    <label style="color: #fff;">.</label><br />
                                                    <asp:Button ID="btnAgregarfecha" runat="server" Text="<%$Resources:procesos.language, agregarFecha%>" OnClick="btnAgregarfecha_Click" CssClass="btn btn-info btn-sm" />
                                                </div>
                                            </div>
                                        </div>

                                        <hr style="margin-bottom: 10px; margin-top: 0px;" />
                                        <div style="height: 50vh; overflow-y: auto;">
                                            <asp:GridView ID="grvFechasEvento" ShowFooter="true" runat="server" CssClass="table table-bordered table-hover table-responsive" AutoGenerateColumns="false">
                                                <Columns>
                                                    <asp:BoundField DataField="RowNumber" HeaderText="#" />
                                                    <asp:TemplateField HeaderText="Espacio">
                                                        <ItemTemplate>
                                                            <asp:DropDownList ID="ddlEspacio_grvEvt" runat="server" CssClass="form-control input-sm" AppendDataBoundItems="true">
                                                                <asp:ListItem Value="-1">Select</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Fecha">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtFecha" Text='<%#Eval("Column2") %>' runat="server" CssClass="form-control input-sm" TextMode="Date"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Hora Inicio">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtHoraInicio" Text='<%#Eval("Column3") %>' runat="server" CssClass="form-control input-sm" TextMode="Time"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Hora Final">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtHoraFinal" Text='<%#Eval("Column4") %>' runat="server" CssClass="form-control input-sm" TextMode="Time"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Encargado">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtCedulaEncargado" Text='<%#Eval("Column5") %>' runat="server" CssClass="form-control input-sm" TextMode="SingleLine"></asp:TextBox>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Control PC">
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkControlPC_grvEspacio" Text="Activar" runat="server" CssClass="form-control input-sm" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="RemoveRow" runat="server"
                                                                OnClick="RemoveRow_Click">Eliminar</asp:LinkButton>
                                                        </ItemTemplate>
                                                        <FooterStyle HorizontalAlign="Right" />
                                                        <FooterTemplate>
                                                            <asp:Button ID="ButtonAdd" runat="server" Text="Agregar Fecha" CssClass="btn btn-primary btn-sm" OnClick="ButtonAdd_Click" />
                                                        </FooterTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                <RowStyle BackColor="#EFF3FB" />
                                                <EditRowStyle BackColor="#2461BF" />
                                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                                <AlternatingRowStyle BackColor="White" />
                                            </asp:GridView>
                                        </div>
                                        <hr style="margin-bottom: 10px; margin-top: 0px;" />
                                        <div class="row">
                                            <div class="col-sm-9"></div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group-sm">
                                                    <asp:Button ID="btnGuardarFechasEvento" runat="server" CssClass="btn btn-primary btn-sm" Text="<%$Resources:procesos.language, guardar%>" OnClick="btnGuardarFechasEvento_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <!-- Pestaña Eventos - Fin -->
                        </div>
                        <!-- Pestaña Eventos - Final -->

                        <!-- Pestaña Persona - Inicio -->
                        <div id="tabPersona" class="tab-pane fade in">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabPersona1" runat="server">
                                        <asp:Literal ID="ltlMsgPersona" runat="server"></asp:Literal>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize9" runat="server" Text="<%$Resources:procesos.language, tipoId%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlTpId_Persona" runat="server" AutoPostBack="true" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlTpId_Persona_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize10" runat="server" Text="<%$Resources:procesos.language, id%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtId_Persona" runat="server" CssClass="form-control input-sm" OnTextChanged="txtId_Persona_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender TargetControlID="txtId_Persona" ID="mskIdPersona_Persona" runat="server" Mask="9-9999-9999" />
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize14" runat="server" Text="<%$Resources:procesos.language, nombreCompleto%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNombre_Persona" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize15" runat="server" Text="<%$Resources:procesos.language, WhatsApp%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtWhatsApp_Persona" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender ID="mskCel_Persona" runat="server" Mask="9999-9999" TargetControlID="txtWhatsApp_Persona" ClearMaskOnLostFocus="true" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize16" runat="server" Text="<%$Resources:procesos.language, telefono%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtTelefono_Persona" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender ID="mskTel_Persona" Mask="9999-9999" runat="server" TargetControlID="txtTelefono_Persona" ClearMaskOnLostFocus="true" />
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize17" runat="server" Text="<%$Resources:procesos.language, email%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtEmail_Persona" runat="server" CssClass="form-control input-sm" TextMode="Email"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize18" runat="server" Text="<%$Resources:procesos.language, estadoCivil%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEstadoCivil_Persona" runat="server" CssClass="form-control input-sm">
                                                        <asp:ListItem Text="Soltero(a)" Value="Soltero(a)"></asp:ListItem>
                                                        <asp:ListItem Text="Casado(a)" Value="Casado(a)"></asp:ListItem>
                                                        <asp:ListItem Text="Viudo(a)" Value="Viudo(a)"></asp:ListItem>
                                                        <asp:ListItem Text="Divorciado(a)" Value="Divorciado(a)"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize19" runat="server" Text="<%$Resources:procesos.language, fechaNacimiento%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="form-control input-sm" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-6">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize20" runat="server" Text="<%$Resources:procesos.language, direccion%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtDireccion_Persona" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize21" runat="server" Text="<%$Resources:procesos.language, sexo%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlSexo_Persona" runat="server" CssClass="form-control input-sm">
                                                        <asp:ListItem Text="Femenino" Value="female" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Masculino" Value="male"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize22" runat="server" Text="<%$Resources:procesos.language, pais%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlPais_Persona" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize23" runat="server" Text="<%$Resources:procesos.language, contactoEmergencia%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNombre_Contacto_Persona" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize24" runat="server" Text="<%$Resources:procesos.language, TelContactoEmergencia%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtTel_Contacto_Persona" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender ID="MaskedEditExtender4" Mask="9999-9999" TargetControlID="txtTel_Contacto_Persona" ClearMaskOnLostFocus="true" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize25" runat="server" Text="<%$Resources:procesos.language, estado%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEstado" runat="server" CssClass="form-control input-sm">
                                                        <asp:ListItem Text="Activo" Value="1"></asp:ListItem>
                                                        <asp:ListItem Text="Inactivo" Value="0"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group-sm">
                                                    <label style="color: transparent;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Persona" CssClass="btn btn-primary btn-sm" Text="<%$Resources:procesos.language, guardar%>" runat="server" OnClick="btnGuardar_Persona_Click" />
                                                    <asp:Button ID="btnCancelar_Persona" CssClass="btn btn-warning btn-sm" Text="<%$Resources:procesos.language, cancelar%>" runat="server" OnClick="btnCancelar_Persona_Click" />
                                                    <asp:Button ID="btnEliminar_Persona" CssClass="btn btn-danger btn-sm" Text="<%$Resources:procesos.language, eliminar%>" runat="server" OnClick="btnEliminar_Persona_Click" />

                                                </div>
                                            </div>
                                        </div>
                                        <hr style="margin-bottom: 10px; margin-top: 10px;" />
                                        <div class="row">
                                            <div class="col-sm-9">
                                            </div>
                                            <div class="col-sm-3">
                                                <asp:TextBox ID="txtBuscar_Persona" runat="server" CssClass="form-control input-sm" onkeyup="Search_Gridview(this,'ContentPlaceHolder1_grvPersonas_persona')"></asp:TextBox>
                                                <ajaxToolkit:TextBoxWatermarkExtender runat="server" BehaviorID="txtBuscar_Persona_TextBoxWatermarkExtender" TargetControlID="txtBuscar_Persona" ID="txtBuscar_Persona_TextBoxWatermarkExtender" WatermarkText="Buscar"></ajaxToolkit:TextBoxWatermarkExtender>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="height: 45vh; overflow-y: auto;">
                                            <asp:GridView ID="grvPersonas_persona" runat="server" DataKeyNames="idTipoIdentificacion,numero_identificacion" CssClass="table table-responsive table-hover table-condensed" ShowHeaderWhenEmpty="true" EmptyDataText="No hay Datos" ShowHeader="true" AutoGenerateColumns="false" OnRowCommand="grvPersonas_persona_RowCommand" OnPageIndexChanging="grvPersonas_persona_PageIndexChanging">
                                                <Columns>
                                                    <asp:BoundField HeaderText="idTipoIdentificacion" DataField="idTipoIdentificacion" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="ID" DataField="numero_identificacion"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Nombre Completo" DataField="nombre_Completo"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Celular" DataField="celular"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Telefono" DataField="telefono"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Email" DataField="email"></asp:BoundField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                            <asp:Button ID="btnEnviarWhats" runat="server" CommandName="EnviarWhatsApp" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:procesos.language, enviarWhatsapp%>" CssClass="btn btn-success btn-xs" OnClientClick="document.forms[0].target = '_blank';" />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" VerticalAlign="Middle" HorizontalAlign="Center" />
                                            </asp:GridView>
                                        </div>

                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Pestaña Persona - Final -->

                        <!-- Pestaña Inscripcion - Inicio -->
                        <div id="tabInscripcion" class="tab-pane fade in">
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabInscripcion1" runat="server">
                                        <asp:Literal ID="ltlInscripcion" runat="server"></asp:Literal>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize26" runat="server" Text="<%$Resources:procesos.language, tipoId%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlTpPersona_Inscrip" AutoPostBack="true" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlTpPersona_Inscrip_SelectedIndexChanged"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize27" runat="server" Text="<%$Resources:procesos.language, Id%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtId_Inscrip" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender ID="mskIdPersona_Inscripcion" Mask="9-9999-9999" TargetControlID="txtId_Inscrip" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize28" runat="server" Text="<%$Resources:procesos.language, evento%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEvento_Inscrip" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlEvento_Inscrip_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize29" runat="server" Text="<%$Resources:procesos.language, periodo%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlPeriodo_Inscrip" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlPeriodo_Inscrip_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize30" runat="server" Text="<%$Resources:procesos.language, banco%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlBanco_Inscrip" runat="server" CssClass="form-control input-sm">
                                                        <asp:ListItem Text="Banco de Costa Rica" Value="BCR"></asp:ListItem>
                                                        <asp:ListItem Text="Banco Nacional" Value="BN"></asp:ListItem>
                                                        <asp:ListItem Text="BAC Credomatic" Value="BAC"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize31" runat="server" Text="<%$Resources:procesos.language, monto%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtMonto_Inscrip" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize32" runat="server" Text="<%$Resources:procesos.language, numComprobante%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNumComprobante_Inscrip" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize33" runat="server" Text="<%$Resources:procesos.language, fecha%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtFechaComprobante_Incrip" runat="server" CssClass="form-control input-sm" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize34" runat="server" Text="<%$Resources:procesos.language, poliza%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNumPoliza_Incrip" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize35" runat="server" Text="<%$Resources:procesos.language, fecha%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtFechaPoliza" TextMode="Date" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-top: 10px">
                                            <div class="col-sm-6">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize36" runat="server" Text="<%$Resources:procesos.language, observaciones%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObservaciones_Inscrip" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize42" runat="server" Text="<%$Resources:procesos.language, situacionEspecial%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtSituacion_Inscrip" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-top: 10px">
                                            <div class="col-sm-6">
                                                <div class="form-group-sm">
                                                    <label>Leer Excel</label>
                                                    <a href="/Archivos/EjemploExcelCAI.xlsx" download>Descarga Ejemplo</a>
                                                    <div class="input-group">
                                                        <asp:FileUpload ID="fileUp" runat="server" CssClass="custom-file-input" AllowMultiple="false" />
                                                        <div class="input-group-btn">
                                                            <asp:Button ID="btnLeerExcel" runat="server" Text="Leer Excel" CssClass="btn btn-default btn-sm" OnClick="btnLeerExcel_Click" />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group-sm">
                                                    <label style="color: transparent;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Inscripcion" CssClass="btn btn-primary btn-sm" Text="<%$Resources:procesos.language, guardar%>" runat="server" OnClick="btnGuardar_Inscripcion_Click" />
                                                    <asp:Button ID="btnCancelar_Inscripcion" CssClass="btn btn-warning btn-sm" Text="<%$Resources:procesos.language, cancelar%>" runat="server" OnClick="btnCancelar_Inscripcion_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr style="margin-bottom: 10px; margin-top: 10px;" />
                                        <div class="row">
                                            <div class="col-sm-9">
                                            </div>
                                            <div class="col-sm-3">
                                                <asp:TextBox ID="txtBuscar_Inscripcion" runat="server" CssClass="form-control input-sm" onkeyup="Search_Gridview(this,'ContentPlaceHolder1_grvInscripcion')"></asp:TextBox>
                                                <ajaxToolkit:TextBoxWatermarkExtender runat="server" BehaviorID="txtBuscar_Inscripcion_TextBoxWatermarkExtender" TargetControlID="txtBuscar_Inscripcion" ID="txtBuscar_InscripcionWatermarkExtender1" WatermarkText="Buscar"></ajaxToolkit:TextBoxWatermarkExtender>
                                            </div>
                                        </div>
                                        <br />
                                        <div style="height: 45vh; overflow-y: auto;">
                                            <asp:GridView ID="grvInscripcion" runat="server" DataKeyNames="idTipoId,idPersona,idEvento,idPeriodo,banco,monto,numComprobante,fechaComprobante,poliza,fechaPoliza,Observaciones,situacionEspecial" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" EmptyDataText="No hay personas Matriculadas" CssClass="table table-responsive table-bordered" OnRowCommand="grvInscripcion_RowCommand">
                                                <Columns>
                                                    <asp:BoundField HeaderText="idTipoIdentificacion" DataField="idTipoId" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="C&#233;dula" DataField="idPersona"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Nombre Completo" DataField="nombre_Completo"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Evento" DataField="idEvento" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Periodo" DataField="idPeriodo" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Banco" DataField="banco" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Monto" DataField="monto" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Comprobante" DataField="numComprobante" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Fecha Comprobante" DataField="fechaComprobante" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Poliza" DataField="poliza" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="Fecha Poliza" DataField="fechaPoliza" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="observaciones" DataField="Observaciones" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="situacion Especial" DataField="situacionEspecial" Visible="false"></asp:BoundField>
                                                    <asp:BoundField HeaderText="estado" DataField="estado" Visible="false"></asp:BoundField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                            <asp:Button ID="btnImprimir" runat="server" CommandName="Imprimir" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:procesos.language, imprimir%>" CssClass="btn btn-default btn-xs" />
                                                            <asp:Button ID="btnEliminar_Inscripcion" runat="server" CommandName="Eliminar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:procesos.language, eliminar%>" CssClass="btn btn-danger btn-xs" />
                                                            <ajaxToolkit:ConfirmButtonExtender runat="server" ConfirmText="¿Desea eliminar este registro?" BehaviorID="btnEliminar_Inscripcion_ConfirmButtonExtender" TargetControlID="btnEliminar_Inscripcion" ID="btnEliminar_Inscripcion_ConfirmButtonExtender"></ajaxToolkit:ConfirmButtonExtender>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                </Columns>
                                                <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btnLeerExcel" />
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Pestaña Inscripcion - Final -->

                        <!-- Pestaña Periodo - Inicio -->
                        <div id="tabPeriodo" class="tab-pane fade in">
                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabPeriodo1" runat="server">
                                        <asp:Literal ID="ltlPeriodo" runat="server"></asp:Literal>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-3">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize37" runat="server" Text="<%$Resources:procesos.language, periodo%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNombre_Periodo" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                    <asp:HiddenField ID="hdfIdPeriodo" Value="0" runat="server" />
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize38" runat="server" Text="<%$Resources:procesos.language, observaciones%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtObservaciones_Periodo" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize39" runat="server" Text="<%$Resources:procesos.language, fechaFinal%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEstado_Periodo" runat="server" CssClass="form-control input-sm">
                                                        <asp:ListItem Text="Activo" Value="true" Selected="True"></asp:ListItem>
                                                        <asp:ListItem Text="Inactivo" Value="false"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group-sm">
                                                    <label style="color: transparent;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Periodo" CssClass="btn btn-primary btn-sm" Text="Guardar" runat="server" OnClick="btnGuardar_Periodo_Click" />
                                                    <asp:Button ID="btnCancelar_Periodo" CssClass="btn btn-warning btn-sm" Text="Cancelar" runat="server" OnClick="btnCancelar_Periodo_Click" />
                                                    <asp:Button ID="btnEliminar_Periodo" CssClass="btn btn-danger btn-sm" Text="Eliminar" runat="server" OnClick="btnEliminar_Periodo_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr style="margin-bottom: 10px; margin-top: 10px;" />
                                        <asp:GridView ID="grvPeriodo" DataKeyNames="idPeriodo" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="table table-responsive table-bordered" runat="server" OnRowCommand="grvPeriodo_RowCommand">
                                            <Columns>
                                                <asp:BoundField HeaderText="Id" Visible="False" DataField="idPeriodo"></asp:BoundField>
                                                <asp:BoundField HeaderText="Periodo" DataField="periodo_descripcion"></asp:BoundField>
                                                <asp:BoundField HeaderText="Observaciones" DataField="observaciones"></asp:BoundField>
                                                <asp:BoundField HeaderText="Estado" DataField="estado" Visible="false"></asp:BoundField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Pestaña Periodo - Final -->

                        <!-- Pestaña Tipo Evento - Inicio -->
                        <div id="tabTipoEvento" class="tab-pane fade in">
                            <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabTipoEvento1" runat="server">
                                        <asp:Literal ID="ltlTipoEvento" runat="server"></asp:Literal>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-4">
                                                <label>
                                                    <asp:Localize ID="Localize40" runat="server" Text="<%$Resources:procesos.language, tipoEvento%>"></asp:Localize></label>
                                                <asp:TextBox ID="txtNombre_TpEvento" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                <asp:HiddenField ID="hdfIdTpEvento" Value="0" runat="server" />
                                            </div>
                                            <div class="col-sm-4">
                                                <label>
                                                    <asp:Localize ID="Localize41" runat="server" Text="<%$Resources:procesos.language, observaciones%>"></asp:Localize></label>
                                                <asp:TextBox ID="txtObservaciones_TpEvento" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                            </div>
                                            <div class="col-sm-3 text-right">
                                                <div class="form-group-sm">
                                                    <label style="color: transparent;">.</label><br />
                                                    <asp:Button ID="btnGuardarTpEvento" CssClass="btn btn-primary btn-sm" Text="<%$Resources:procesos.language, guardar%>" runat="server" OnClick="btnGuardarTpEvento_Click" />
                                                    <asp:Button ID="btnCancelarTpEvento" CssClass="btn btn-warning btn-sm" Text="<%$Resources:procesos.language, cancelar%>" runat="server" OnClick="btnCancelarTpEvento_Click" />
                                                    <asp:Button ID="btnEliminarTpEvento" CssClass="btn btn-danger btn-sm" Text="<%$Resources:procesos.language, eliminar%>" runat="server" OnClick="btnEliminarTpEvento_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr style="margin-bottom: 10px; margin-top: 10px;" />
                                        <asp:GridView ID="grvTipoEvento" runat="server" DataKeyNames="idTipoEvento" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="table table-responsive table-bordered" OnRowCommand="grvTipoEvento_RowCommand">
                                            <Columns>
                                                <asp:BoundField HeaderText="Id" DataField="idTipoEvento" Visible="false"></asp:BoundField>
                                                <asp:BoundField HeaderText="Tipo Evento" DataField="tipoEvento_descripcion"></asp:BoundField>
                                                <asp:BoundField HeaderText="Observaciones" DataField="observaciones"></asp:BoundField>
                                                <asp:BoundField HeaderText="Estado" DataField="estado" Visible="false"></asp:BoundField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                        <!-- Pestaña Tipo Evento - Final -->

                        <div id="tabAsistencia" class="tab-pane fade in">
                            <asp:UpdatePanel ID="updatePanel6" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" id="tabAsistencia1" runat="server">
                                        <asp:Literal ID="ltlAsistencia" runat="server"></asp:Literal>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-4">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize43" runat="server" Text="<%$Resources:procesos.language, evento%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEvento_Asistencia" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlEvento_Asistencia_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize44" runat="server" Text="<%$Resources:procesos.language, periodo%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlPeriodo_Asistencia" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlPeriodo_Asistencia_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize45" runat="server" Text="<%$Resources:procesos.language, fecha%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlFecha_Asistencia" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlFecha_Asistencia_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize46" runat="server" Text="<%$Resources:procesos.language, tipoId%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlTipoIdentificacion_Asistencia" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlTipoIdentificacion_Asistencia_SelectedIndexChanged" AutoPostBack="true"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize47" runat="server" Text="<%$Resources:procesos.language, id%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtIdPersona_Asistencia" runat="server" CssClass="form-control input-sm" OnTextChanged="txtIdPersona_Asistencia_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender TargetControlID="txtIdPersona_Asistencia" ID="mskIdPersona_Asistencia" runat="server" Mask="9-9999-9999" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row" style="padding-top: 10px;">
                                            <div class="col-sm-4">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize48" runat="server" Text="<%$Resources:procesos.language, nombrecompleto%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNombrePersona_Asistencia" runat="server" CssClass="form-control input-sm" Enabled="false"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize49" runat="server" Text="<%$Resources:procesos.language, horaInicio%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtHoraIngreso_Asistencia" runat="server" CssClass="form-control input-sm" TextMode="Time"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize50" runat="server" Text="<%$Resources:procesos.language, horaFinal%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtHoraSalida_Asistencia" runat="server" CssClass="form-control input-sm" TextMode="Time"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-2">
                                                <div class="form-group-sm">
                                                    <label>
                                                        <asp:Localize ID="Localize52" runat="server" Text="<%$Resources:procesos.language, numPC%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNumPC" runat="server" CssClass="form-control input-sm"></asp:TextBox>
                                                    <ajaxToolkit:MaskedEditExtender runat="server" Century="2000" BehaviorID="txtNumPC_MaskedEditExtender" TargetControlID="txtNumPC" ID="txtNumPC_MaskedEditExtender" Mask="99"></ajaxToolkit:MaskedEditExtender>
                                                </div>
                                            </div>
                                            <div class="col-sm-2 text-right">
                                                <div class="form-group-sm">
                                                    <label style="color: transparent;">.</label><br />
                                                    <asp:Button ID="btnGuardar_Asitencia" CssClass="btn btn-primary btn-sm" Text="<%$Resources:procesos.language, guardar%>" runat="server" OnClick="btnGuardar_Asitencia_Click" />
                                                    <asp:Button ID="btnCancelar_Asistencia" CssClass="btn btn-warning btn-sm" Text="<%$Resources:procesos.language, cancelar%>" runat="server" OnClick="btnCancelar_Asistencia_Click" />
                                                </div>
                                            </div>
                                        </div>
                                        <hr style="margin-bottom: 10px; margin-top: 10px;" />
                                        <asp:GridView ID="grvAsistencia" runat="server" DataKeyNames="idTipoIdentificacion,identificacion,idEvento,idPeriodo,fecha,nombre_Completo,idAsistencia" EmptyDataText="No hay Asistencia Registrada" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" CssClass="table table-responsive table-bordered" OnRowCommand="grvAsistencia_RowCommand">
                                            <Columns>
                                                <asp:BoundField HeaderText="Tipo Identificacion" DataField="idTipoIdentificacion" Visible="false"></asp:BoundField>
                                                <asp:BoundField HeaderText="ID" DataField="identificacion"></asp:BoundField>
                                                <asp:BoundField HeaderText="Nombre Completo" DataField="nombre_Completo"></asp:BoundField>
                                                <asp:BoundField HeaderText="Hora Ingreso" DataField="horaIngreso"></asp:BoundField>
                                                <asp:BoundField HeaderText="Hora Salida" DataField="horaSalida"></asp:BoundField>
                                                <asp:BoundField HeaderText="Nº de PC" DataField="numPC"></asp:BoundField>
                                                <asp:TemplateField HeaderText="Acciones">
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnModificar" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" CssClass="btn btn-primary btn-xs" />
                                                        <asp:Button ID="btnEliminar_Asistencia" runat="server" CommandName="Eliminar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, eliminar%>" CssClass="btn btn-danger btn-xs" />
                                                        <ajaxToolkit:ConfirmButtonExtender runat="server" ConfirmText="¿Desea Eliminar la Asistencia?" BehaviorID="btnEliminar_Asistencia_ConfirmButtonExtender" TargetControlID="btnEliminar_Asistencia" ID="btnEliminar_Asistencia_ConfirmButtonExtender"></ajaxToolkit:ConfirmButtonExtender>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                                        </asp:GridView>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <!-- Modal Nuevo Evento -->
    <div id="nuevoEvento" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Agregar Evento</h4>
                </div>
                <div class="modal-body" id="modalEvento" runat="server">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="form-group-sm">
                                <label for="email">Nombre del Evento:</label>
                                <asp:HiddenField ID="hdf_Md_IdEvento" Value="0" runat="server" />
                                <asp:TextBox ID="txt_MdEvento_NomEvento" CssClass="input-sm form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group-sm">
                                <label for="email">Tipo Evento:</label>
                                <asp:DropDownList ID="ddl_MdlEvento_TipoEvento" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-3">
                            <div class="form-group-sm">
                                <label for="email">Institución:</label>
                                <asp:DropDownList ID="ddlInstitucion_MdlEvento" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-9">
                            <label for="email">Observaciones:</label>
                            <asp:TextBox ID="txtObservaciones_MdlEvento" CssClass="input-sm form-control" runat="server"></asp:TextBox>
                        </div>
                        <div class="col-sm-3">
                            <br />
                            <div class="btn-group-sm">
                                <asp:Button ID="btn_MdEvento_Cancelar" runat="server" Text="<%$Resources:procesos.language, cancelar%>" CssClass="btn btn-danger btn-sm" OnClick="btn_MdEvento_Cancelar_Click" />
                                <asp:Button ID="btn_MdEvento_Guardar" runat="server" Text="<%$Resources:procesos.language, guardar%>" CssClass="btn btn-primary btn-sm" OnClick="btn_MdEvento_Guardar_Click" />
                            </div>
                        </div>
                    </div>
                    <hr style="margin-bottom: 10px; margin-top: 10px;" />
                    <div class="row">
                        <div class="col-sm-9">
                        </div>
                        <div class="col-sm-3">
                            <asp:TextBox ID="txtBuscar_MdlEvento" runat="server" CssClass="form-control input-sm" onkeyup="Search_Gridview(this,'ContentPlaceHolder1_grvEvento')"></asp:TextBox>
                            <ajaxToolkit:TextBoxWatermarkExtender runat="server" BehaviorID="txtBuscar_MdlEvento_TextBoxWatermarkExtender" TargetControlID="txtBuscar_MdlEvento" ID="txtBuscar_MdlEventoWatermarkExtender1" WatermarkText="Buscar"></ajaxToolkit:TextBoxWatermarkExtender>
                        </div>
                    </div>
                    <br />
                    <asp:GridView ID="grvEvento" runat="server" DataKeyNames="idEvento,idTipoEvento,idInstitucion" AutoGenerateColumns="false" ShowHeaderWhenEmpty="true" CssClass="table table-responsive table-bordered" OnRowCommand="grvEvento_RowCommand">
                        <Columns>
                            <asp:BoundField HeaderText="IdEvento" DataField="idEvento" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="Evento" DataField="nombre_Evento"></asp:BoundField>
                            <asp:BoundField HeaderText="idTipoEvento" DataField="idTipoEvento" Visible="false"></asp:BoundField>
                            <asp:BoundField HeaderText="Tipo Evento" DataField="tipoEvento_descripcion"></asp:BoundField>
                            <asp:BoundField HeaderText="Institucion" DataField="nombre_institucion"></asp:BoundField>
                            <asp:BoundField HeaderText="Observaciones" DataField="observaciones"></asp:BoundField>
                            <asp:BoundField HeaderText="estado" DataField="estado" Visible="false"></asp:BoundField>
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
        <div class="modal-footer">
            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
        </div>
    </div>
    <!-- Fin Modal Nuevo Evento -->


    <!-- Modal Excel -->
    <!-- Modal -->
    <div id="MdlInscripcionExcel" class="modal fade" role="dialog">
        <div class="modal-dialog modal-lg">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                    <h4 class="modal-title">Inscribir estudiantes excel</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group-sm">
                                <label>
                                    <asp:Localize ID="Localize53" runat="server" Text="<%$Resources:procesos.language, evento%>"></asp:Localize></label>
                                <asp:DropDownList ID="ddlEvento_MdlExcel" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="form-group-sm">
                                <label>
                                    <asp:Localize ID="Localize54" runat="server" Text="<%$Resources:procesos.language, periodo%>"></asp:Localize></label>
                                <asp:DropDownList ID="ddlPeriodo_MdlExcel" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-sm-4 text-right">
                            <div class="form-group-sm">
                                <label style="color: transparent;">.</label><br />
                                <asp:Button ID="btnGuardar_MdlExcel" CssClass="btn btn-primary btn-sm" Text="<%$Resources:procesos.language, guardar%>" runat="server" OnClick="btnGuardar_MdlExcel_Click" />
                                <asp:Button ID="BtnCancelar_MdlExcel" CssClass="btn btn-warning btn-sm" Text="<%$Resources:procesos.language, cancelar%>" runat="server" OnClick="BtnCancelar_MdlExcel_Click" />
                            </div>
                        </div>
                    </div>
                    <hr />
                    <asp:GridView ID="grvEstudiantesExcel" runat="server" ShowHeaderWhenEmpty="true" CssClass="table table-responsive table-bordered">
                        <HeaderStyle BackColor="#343341" Font-Bold="True" ForeColor="White" />
                    </asp:GridView>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                </div>
            </div>

        </div>
    </div>
    <!-- fin Modal Excel -->
</asp:Content>
