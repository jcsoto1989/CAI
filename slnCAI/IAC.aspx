<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="IAC.aspx.cs" Inherits="slnCAI.IAC" %>

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
    <asp:HiddenField ID="hfTab" runat="server" Value="tabIAC" />
    <div class="container-fluid" style="overflow: auto;">
        
        <div id="IacPage" runat="server">
            <div class="panel panel-primary">
                <div class="panel-heading">
                    <asp:Localize ID="Localize3" runat="server" Text="<%$Resources:iac.language, informacion%>"></asp:Localize>
                </div>
                <div class="panel-body">
                    <!-- TABS -->
                    <ul class="nav nav-tabs nav-justified" id="myTabs">
                        <asp:Literal ID="ltlTabs" runat="server"></asp:Literal>
                    </ul>

                    <div class="tab-content" runat="server" id="tabs">
                        <!------------------------------------------------------------------------------------------------------------------------>

                        <!-- TAB DATOS DE LA INSTITUCION -->
                        <div id="tabInstitucion" class="tab-pane fade in">
                            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" runat="server" visible="false" id="tabInstitucion1">
                                        <asp:HiddenField ID="hddFIdInst_Ins" runat="server" />
                                        <br />
                                        <asp:Literal ID="ltlMsgIns" runat="server" Visible="false"></asp:Literal>
                                        <!-- INICIO DEL CONTENIDO INSTITUCION -->
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize5" runat="server" Text="<%$Resources:iac.language, nombre%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNombre_Ins" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, nombre2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize6" runat="server" Text="<%$Resources:iac.language, departamento%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtSede_Ins" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, departamento2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize7" runat="server" Text="<%$Resources:iac.language, pais%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlPais_Ins" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize8" runat="server" Text="<%$Resources:iac.language, telefonoinstitucion%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtTel_Ins" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, telefonoinstitucion2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-8">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize9" runat="server" Text="<%$Resources:iac.language, direccion%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtDireccion_Ins" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, direccion2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 3 -->
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize10" runat="server" Text="<%$Resources:iac.language, nombrerepre%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlNombeRe_Ins" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <!-- Fila 4 -->
                                            <div class="col-sm-6 text-center" style="border-right: 1px solid #bbb;">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize11" runat="server" Text="<%$Resources:iac.language, logoinstitucion%>"></asp:Localize></label><br />
                                                    <asp:Image ImageUrl="~/Imagenes/logo.png" ID="imgLgIns_Ins" runat="server" CssClass="img-rounded shadow1" Width="150" Height="125" />
                                                    <br />
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-10">
                                                        <asp:FileUpload ID="flupLgIns_Ins" runat="server" CssClass="form-control" accept="image/*"/>
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <asp:Button ID="btnUpldLgIns_Ins" runat="server" Text="<%$Resources:iac.language, subir%>"
                                                            OnClick="btnUploadInstitution_Click" CssClass="btn btn-info btn-sm" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-6 text-center" style="border-left: 1px solid #bbb;">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize12" runat="server" Text="<%$Resources:iac.language, logodepart%>"></asp:Localize></label><br />
                                                    <asp:Image ImageUrl="~/Imagenes/logo.png" ID="imgLgDepar_Ins" runat="server" CssClass="img-rounded shadow1" Width="150" Height="125" />
                                                    <br />
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-10">
                                                        <asp:FileUpload ID="fluLgDepar_Ins" runat="server" CssClass="form-control" accept="image/*" />
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <asp:Button ID="btnUpldLgDepart_Ins" runat="server" Text="<%$Resources:iac.language, subir%>" CssClass="btn btn-info btn-sm"
                                                            OnClick="btnUpldLgDepart_Ins_Click" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 5 -->
                                            <div class="col-sm-8"></div>
                                            <div class="col-sm-4 text-right">
                                                <asp:Button ID="btnGuardar_Ins" runat="server" Text="<%$Resources:iac.language, guardar%>" CssClass="btn btn-primary btn-sm"
                                                    OnClick="btnGuardar_Ins_Click" />
                                                <asp:Button ID="btnCancelar_Ins" runat="server" Text="<%$Resources:iac.language, cancelar%>" CssClass="btn btn-warning btn-sm"
                                                    OnClick="btnCancelar_Ins_Click" />
                                            </div>
                                        </div>
                                        <br />
                                        <!-- FIN DEL CONTENIDO INSTITUCION -->
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger ControlID="btnUpldLgIns_Ins"/>
                                    <asp:PostBackTrigger ControlID="btnUpldLgDepart_Ins"/>
                                </Triggers>
                            </asp:UpdatePanel>

                        </div>

                        <!------------------------------------------------------------------------------------------------------------------------>

                        <!-- TAB DATOS DEL IAC -->
                        <div id="tabIAC" class="tab-pane fade">
                            <!-- INICIO DEL CONTENIDO IAC-->
                            <div class="container-fluid shadow" runat="server" visible="false" id="tabIAC1">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <br />
                                        <asp:Literal ID="ltlMsgIAC" runat="server"></asp:Literal>
                                        <div class="row">
                                            <!-- Fila 1-->
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize13" runat="server" Text="<%$Resources:iac.language, nombreiac%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNombre_IAC" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, nombreiac2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize14" runat="server" Text="<%$Resources:iac.language, direccioniac%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtDireccion_IAC" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, direccioniac2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize15" runat="server" Text="<%$Resources:iac.language, correo%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtEmail_IAC" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, correo2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 2-->
                                            <div class="col-sm-4">
                                                <div class="form-group text-center">
                                                    <p style="border-bottom: 1px solid #bbb; font-weight: bold;">
                                                        <asp:Localize ID="Localize17" runat="server" Text="<%$Resources:iac.language, telefono1%>"></asp:Localize>
                                                    </p>
                                                    <div class="row">
                                                        <!-- Telefono y Extension 1-->
                                                        <div class="col-sm-8">
                                                            <label>
                                                                <asp:Localize ID="Localize16" runat="server" Text="<%$Resources:iac.language, telefono%>"></asp:Localize></label>
                                                            <asp:TextBox ID="txtTel1_IAC" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, telefono4%>"></asp:TextBox>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <label>Ext:</label>
                                                            <asp:TextBox ID="txtExt1_IAC" runat="server" CssClass="form-control input-sm" placeholder="Ext"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group text-center">
                                                    <p style="border-bottom: 1px solid #bbb; font-weight: bold;">
                                                        <asp:Localize ID="Localize18" runat="server" Text="<%$Resources:iac.language, telefono2%>"></asp:Localize>
                                                    </p>
                                                    <div class="row">
                                                        <!-- Telefono y Extension 2-->
                                                        <div class="col-sm-8">
                                                            <label>
                                                                <asp:Localize ID="Localize21" runat="server" Text="<%$Resources:iac.language, telefono%>"></asp:Localize></label>
                                                            <asp:TextBox ID="txtTel2_IAC" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, telefono4%>"></asp:TextBox>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <label>Ext:</label>
                                                            <asp:TextBox ID="txtExt2_IAC" runat="server" CssClass="form-control input-sm" placeholder="Ext"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group text-center">
                                                    <p style="border-bottom: 1px solid #bbb; font-weight: bold;">
                                                        <asp:Localize ID="Localize19" runat="server" Text="<%$Resources:iac.language, telefono3%>"></asp:Localize>
                                                    </p>
                                                    <div class="row">
                                                        <!-- Telefono y Extension 3-->
                                                        <div class="col-sm-8">
                                                            <label>
                                                                <asp:Localize ID="Localize20" runat="server" Text="<%$Resources:iac.language, telefono%>"></asp:Localize></label>
                                                            <asp:TextBox ID="txtTel3_IAC" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, telefono4%>"></asp:TextBox>
                                                        </div>
                                                        <div class="col-sm-4">
                                                            <label>Ext:</label>
                                                            <asp:TextBox ID="txtExt3_IAC" runat="server" CssClass="form-control input-sm" placeholder="Ext"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 3-->
                                            <div class="col-sm-12 text-center">
                                                <div class="form-group">
                                                    <label>Logo IAC:</label><br />
                                                    <asp:Image ImageUrl="~/Imagenes/logo.png" ID="imgLg_IAC" runat="server" CssClass="img-rounded shadow1" Width="150" Height="125" />
                                                    <br />
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-10">
                                                        <asp:FileUpload ID="fluLg_IAC" runat="server" CssClass="form-control" accept="image/*"/>
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <asp:Button ID="btnUpdlLg_IAC" runat="server" Text="<%$Resources:iac.language, subir%>"
                                                            OnClick="btnUpdlLg_IAC_Click" CssClass="btn btn-info btn-sm" />
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 4-->
                                            <div class="col-sm-8"></div>
                                            <div class="col-sm-4 text-right">
                                                <asp:Button ID="btnGuardar_IAC" runat="server" Text="<%$Resources:iac.language, guardar%>" CssClass="btn btn-primary btn-sm"
                                                    OnClick="btnGuardar_IAC_Click" />
                                                <asp:Button ID="btnCancelar_IAC" runat="server" Text="<%$Resources:iac.language, cancelar%>" CssClass="btn btn-warning btn-sm"
                                                    OnClick="btnCancelar_IAC_Click" />
                                            </div>
                                        </div>

                                        <br />
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger  ControlID="btnUpdlLg_IAC"/>
                                    </Triggers>
                                </asp:UpdatePanel>
                            </div>
                            <!-- FIN DEL CONTENIDO IAC-->
                        </div>

                        <!------------------------------------------------------------------------------------------------------------------------>

                        <!-- TAB DATOS DE LOS COLABORADORES -->
                        <div id="tabColaboradores" class="tab-pane fade">
                            <!-- INICIO DEL CONTENIDO COLABORADORES-->
                            <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                <ContentTemplate>
                                    <div class="container-fluid shadow" runat="server" visible="false" id="tabColaboradores1">
                                        <br />
                                        <asp:Literal ID="ltlMsgCol" runat="server" Visible="false"></asp:Literal>
                                        <div class="row">
                                            <!-- Fila 1 -->
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize22" runat="server" Text="<%$Resources:iac.language, numeroid%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtID_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, numeroid2%>" OnTextChanged="txtID_Col_TextChanged" AutoPostBack="true"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize23" runat="server" Text="<%$Resources:iac.language, nombrecompleto%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtNombre_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, nombrecompleto2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize24" runat="server" Text="<%$Resources:iac.language, puesto%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlPuesto_Col" runat="server" CssClass="form-control input-sm"></asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize25" runat="server" Text="<%$Resources:iac.language, celular%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtCelular_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, celular2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 2 -->
                                            <div class="col-sm-3">
                                                <div class="row">
                                                    <!-- Telefono y Extension -->
                                                    <div class="col-sm-8">
                                                        <div class="form-group">
                                                            <label>
                                                                <asp:Localize ID="Localize26" runat="server" Text="<%$Resources:iac.language, telefono%>"></asp:Localize></label>
                                                            <asp:TextBox ID="txtTel_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, telefono4%>"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-4">
                                                        <div class="form-group">
                                                            <label>Ext:</label>
                                                            <asp:TextBox ID="txtExt_Col" runat="server" CssClass="form-control input-sm" placeholder="Ext"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize27" runat="server" Text="<%$Resources:iac.language, correo%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtEmail_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, correo2%>"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize28" runat="server" Text="<%$Resources:iac.language, fechaingreso%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtFechaIng_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, fechaingreso2%>" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize29" runat="server" Text="<%$Resources:iac.language, estado%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlEstado_Col" runat="server" CssClass="form-control input-sm">
                                                        <asp:ListItem Text="Activo" Value="true"></asp:ListItem>
                                                        <asp:ListItem Text="Inactivo" Value="false"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 3 -->
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize30" runat="server" Text="<%$Resources:iac.language, sexo%>"></asp:Localize></label>
                                                    <asp:DropDownList ID="ddlSexo_Col" runat="server" CssClass="form-control input-sm">
                                                        <asp:ListItem Text="Masculino" Value="Masculino" Selected="true" />
                                                        <asp:ListItem Text="Femenino" Value="Femenino" />
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-3">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize31" runat="server" Text="<%$Resources:iac.language, fechanacimiento%>"></asp:Localize></label>
                                                    <asp:TextBox ID="txtFechaNac_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, fechanacimiento2%>" TextMode="Date"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="row">
                                                    <!-- Campo de Texto Tarea y Boton para Agregar Tarea -->
                                                    <div class="col-sm-9">
                                                        <div class="form-group">
                                                            <label>
                                                                <asp:Localize ID="Localize32" runat="server" Text="<%$Resources:iac.language, tareaquedesempena%>"></asp:Localize></label>
                                                            <asp:TextBox ID="txtTarea_Col" runat="server" CssClass="form-control input-sm" placeholder="<%$Resources:iac.language, tareaquedesempena2%>"></asp:TextBox>
                                                        </div>
                                                    </div>
                                                    <div class="col-sm-3">
                                                        <label style="color: #fff;">.</label><br />
                                                        <asp:Button ID="btnAgregarTa_Col" runat="server" Text="<%$Resources:iac.language, agregar%>" CssClass="btn btn-default btn-sm" OnClick="btnAgregarTa_Col_Click" />
                                                    </div>
                                                </div>

                                            </div>
                                        </div>
                                        <div class="row text-center">
                                            <!-- Fila 4 -->
                                            <div class="col-sm-4">
                                                <div class="form-group text-center">
                                                    <label>
                                                        <asp:Localize ID="Localize33" runat="server" Text="<%$Resources:iac.language, fotografia%>"></asp:Localize></label><br />
                                                    <asp:Image ImageUrl="~/Imagenes/logo.png" ID="imgFoto_Col" runat="server" CssClass="img-rounded shadow1" Width="150" Height="117" />
                                                    <br />
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-10">
                                                        <asp:FileUpload ID="flupFoto_Col" runat="server" CssClass="form-control" accept="image/*" />
                                                    </div>
                                                    <div class="col-sm-1">
                                                        <asp:Button ID="btnUpldFoto_Col" runat="server" Text="<%$Resources:iac.language, subir%>"
                                                            OnClick="btnUpdFotoCol_Click" CssClass="btn btn-info btn-sm" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="row">
                                                    <div class="col-sm-12">
                                                        <div class="form-group">
                                                            <label>
                                                                <asp:Localize ID="Localize34" runat="server" Text="<%$Resources:iac.language, files%>"></asp:Localize></label><asp:Button ID="btnDescargarArchivo_Col" runat="server" Text="<%$Resources:iac.language, descargar%>" CssClass="btn btn-default btn-xs" OnClick="btnDescargarArchivo_Col_Click"/>
                                                            <asp:ListBox ID="lstArchivo_Col" runat="server" CssClass="form-control input-sm" Rows="7" Style="height: 100%;" OnSelectedIndexChanged="lstArchivo_Col_SelectedIndexChanged" AutoPostBack="True"></asp:ListBox>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col-sm-9">
                                                        <asp:FileUpload ID="FlupFile_Col" runat="server" CssClass="form-control" />
                                                    </div>
                                                    <div class="col-sm-2">
                                                        <asp:Button ID="btnUpldFile_Col" runat="server" Text="<%$Resources:iac.language, subir%>"
                                                            OnClick="btnUpldFile_Col_Click" CssClass="btn btn-info btn-sm" />
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group">
                                                    <label>
                                                        <asp:Localize ID="Localize35" runat="server" Text="<%$Resources:iac.language, tareasdesempena%>"></asp:Localize></label>
                                                    <asp:ListBox ID="lstTarea_Col" runat="server" CssClass="form-control input-sm" Rows="7" Style="height: 100%;" OnSelectedIndexChanged="lstTarea_Col_SelectedIndexChanged" AutoPostBack="true"></asp:ListBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <!-- Fila 5 -->
                                            <div class="col-sm-6"></div>
                                            <div class="col-sm-6 text-right">
                                                <asp:Button ID="btnGuardar_Col" runat="server" Text="<%$Resources:iac.language, guardar%>" CssClass="btn btn-primary btn-sm"
                                                    OnClick="btnGuardar_Col_Click" />
                                                <asp:Button ID="btnCancelar_Col" runat="server" Text="<%$Resources:iac.language, cancelar%>" CssClass="btn btn-warning btn-sm"
                                                    OnClick="btnCancelar_Col_Click" />
                                                <asp:Button ID="btnEliminar_Col" runat="server" Text="<%$Resources:iac.language, eleminar%>" CssClass="btn btn-danger btn-sm"
                                                    OnClick="btnEliminar_Col_Click" />
                                            </div>
                                        </div>
                                        <hr />
                                        <div class="row">
                                            <!-- Fila 6 -->
                                            <div class="col-sm-12">
                                                <div class="table-responsive">
                                                    <asp:GridView ID="grvColaboradores_Col" CssClass="table table-striped table-bordered table-hover" runat="server" EmptyDataText="No hay datos" ShowHeaderWhenEmpty="true" AutoGenerateColumns="False" OnRowCommand="grvColaboradores_Col_RowCommand" Caption="<%$Resources:iac.language, colaboradores%>" CaptionAlign="Top">
                                                        <Columns>
                                                            <asp:BoundField HeaderText="<%$Resources:iac.language, numeroid2%>" DataField="numero_Identificacion"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:iac.language, nombre2%>" DataField="nombre_Completo"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:iac.language, telefono4%>" DataField="tel_Oficina"></asp:BoundField>
                                                            <asp:BoundField HeaderText="Ext" DataField="ext_Oficina"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:iac.language, celular2%>" DataField="celular"></asp:BoundField>
                                                            <asp:BoundField HeaderText="<%$Resources:iac.language, correo2%>" DataField="email" />
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <asp:Button ID="btnModificar_Col" runat="server" CommandName="Modificar" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" Text="<%$Resources:mantenimiento.language, modificar%>" class="btn btn-primary btn-xs" />
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                    </asp:GridView>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                    </div>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:PostBackTrigger  ControlID="btnUpldFoto_Col"/>
                                    <asp:PostBackTrigger ControlID="btnUpldFile_Col"/>
                                    <asp:PostBackTrigger ControlID="btnDescargarArchivo_Col" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <!-- FIN DEL CONTENIDO COLABORADORES-->
                        </div>

                        <!------------------------------------------------------------------------------------------------------------------------>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
