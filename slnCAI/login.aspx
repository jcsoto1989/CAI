<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="slnCAI.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Login - MEJORIAC</title>

    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/smart_wizard.css" rel="stylesheet" />
    <link href="Content/smart_wizard_theme_circles.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
    <script src="Scripts/jquery.smartWizard.min.js"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#smartwizard').smartWizard();
        });
        function changeImg(imgNumber) {
            var myImages = ["Imagenes/bg/image0.jpg", "Imagenes/bg/image1.jpg", "Imagenes/bg/image2.jpg", "Imagenes/bg/image3.jpg", "Imagenes/bg/image4.jpg", "Imagenes/bg/image5.jpg", "Imagenes/bg/image6.jpg", "Imagenes/bg/image7.jpg", "Imagenes/bg/image8.jpg", "Imagenes/bg/image9.jpg", "Imagenes/bg/image11.jpg", "Imagenes/bg/image12.jpg"];
            var imgShown = document.body.style.backgroundImage;
            var newImgNumber = Math.floor(Math.random() * myImages.length);
            document.body.style.backgroundImage = 'url(' + myImages[newImgNumber] + ')';
        }
        window.onload = changeImg;

    </script>
    <style>
        .form-signin {
            max-width: 400px;
            padding: 15px;
            margin: 0 auto;
            background-color: rgba(255, 255, 255, 0.60);
            padding: 25px 25px;
            width: 100%;
            position: absolute;
            transform: translate(-50%, -50%);
            left: 50%;
            top: 50%;
            border: 0px solid #ccc;
            box-shadow: inset 1px 1px 14px #000;
            border-radius: 35px;
        }

        /* Extra small devices (phones, 600px and down) */
        @media only screen and (max-width: 600px) {
            img {
                width: 80%;
            }

            .bg {
                background-repeat: round;
                background-size: cover;
            }

            #divWizard {
                max-width: 600px;
                height: 100%;
                overflow: scroll;
            }

            #smartwizard {
            }
        }

        /* Small devices (portrait tablets and large phones, 600px and up) */
        @media only screen and (min-width: 600px) {
            .form-signin {
                max-width: 300px;
                padding: 10px 10px;
            }

            img {
                width: 70%;
                padding: 2px;
            }

            hr {
                margin-top: 10px;
                margin-bottom: 10px;
                border: 0;
                border-top: 1px solid #eee;
            }

            .bg {
                background-repeat: round;
            }

            #divWizard {
                max-width: 600px;
                height: 100%;
                overflow: scroll;
            }

            #smartwizard {
            }
        }

        /* Medium devices (landscape tablets, 768px and up) */
        @media only screen and (min-width: 768px) {
            .form-signin {
                max-width: 300px;
                padding: 20px;
            }

            .bg {
                background-repeat: round;
            }
        }

        /* Large devices (laptops/desktops, 992px and up) */
        @media only screen and (min-width: 992px) {
            .form-signin {
                max-width: 300px;
                padding: 20px;
            }

            .bg {
                background-repeat: round;
            }
        }

        /* Extra large devices (large laptops and desktops, 1200px and up) */
        @media only screen and (min-width: 1200px) {
            .form-signin {
                padding: 20px;
            }

            span {
                font-size: 12px;
            }

            .bg {
                background-repeat: round;
            }


            #divWizard {
                max-width: 700px;
                height: auto;
                overflow: hidden;
                padding: 20px;
            }
        }

        html {
            -webkit-background-size: cover;
            -moz-background-size: cover;
            -o-background-size: cover;
            background-size: cover;
        }

        .bg {
            background-attachment: fixed;
            background-size: cover;
        }


        #smartwizard {
        }
    </style>
</head>
<body class="text-center bg" style="background-image: url(Imagenes/bg/image4.jpeg);">
    <div class="container-fluid" style="display: flex; justify-content: center; align-items: center;">
        <form id="form1" runat="server">
            <asp:HiddenField ID="hfTab" runat="server" Value="" />
            <div id="divLogin" runat="server" visible="false" class="form-signin">
                <img class="img img-resposive" src="Imagenes/Iac1.png" alt="" />
                <asp:Literal ID="ltlMensaje" runat="server" Visible="false"></asp:Literal>
                <hr />
                <asp:Label ID="Label1" runat="server" Text="<%$Resources:login.language, btnLogin%>" CssClass="h3 mb-3 font-weight-normal" Style="font-family: Impact;"></asp:Label>
                <br />
                <asp:TextBox ID="txtUser_Lgn" runat="server" class="form-control" placeholder="<%$Resources:login.language, lbluser%>" Style="margin-bottom: 5px; margin-top: 10px;"></asp:TextBox>
                <asp:TextBox ID="txtPassword_Lgn" runat="server" class="form-control" TextMode="Password" placeholder="<%$Resources:login.language, lblpassword%>" Style="margin-bottom: 5px;"></asp:TextBox>
                <asp:DropDownList ID="ddlIdioma_Lgn" runat="server" CssClass="form-control" Style="padding: 0px; padding-left: 8px; margin-bottom: 10px;" AutoPostBack="True">
                    <asp:ListItem Text="<%$Resources:login.language, ddlSpanish%>" Value="es-CR" Selected="True"></asp:ListItem>
                    <asp:ListItem Text="<%$Resources:login.language, ddlEnglish%>" Value="en-US"></asp:ListItem>
                </asp:DropDownList>
                <asp:Button ID="btnIniciar_Lgn" runat="server" Text="<%$Resources:login.language, btnLogin%>" class="btn btn-sm btn-primary btn-block" OnClick="btnIniciar_Lgn_Click" Style="margin-bottom: 5px;" />
                <p class="mt-5 mb-3 text-muted" style="margin: 0 0 0px;">Derechos Reservados© 2018</p>
            </div>
            <div id="divWizard" runat="server" class="form-signin" style="max-width: 600px;">
                <div>
                    <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                    <img src="Imagenes/Iac1.png" class="img img-responsive text-center" style="margin: auto; width: 50%; padding-bottom: 25px" />
                    <div id="smartwizard" style="border-top-left-radius: 10px; border-top-right-radius: 10px;" class="text-center">
                        <ul id="myTabs" style="background-color: #002442; color: #fff; border-top-left-radius: 10px; border-top-right-radius: 10px;">
                            <li><a href="#step-1">
                                <asp:Label runat="server" Text="<%$Resources:login.language, configServer%>"></asp:Label><br />
                                <small>
                                    <asp:Label runat="server" Text="<%$Resources:login.language, configDb%>"></asp:Label></small></a></li>
                            <li><a href="#step-2">
                                <asp:Label runat="server" Text="<%$Resources:login.language, dbScript%>"></asp:Label><br />
                                <small>
                                    <asp:Label runat="server" Text="<%$Resources:login.language, useraccount%>"></asp:Label></small></a></li>
                            <li><a href="#step-3">
                                <asp:Label runat="server" Text="<%$Resources:login.language, useraccount%>"></asp:Label><br />
                                <small>
                                    <asp:Label runat="server" Text="<%$Resources:login.language, adminAccount%>"></asp:Label></small></a></li>
                        </ul>
                        <div>
                            <div id="step-1" class="">
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_Conexion" runat="server"></asp:Literal>
                                        <div class="row">
                                            <div class="col-sm-12 text-center">
                                                <div class="form-group-sm">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, server%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtDBServer"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-12  text-center">
                                                <div class="form-group-sm">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, dbUser%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtDBuser"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-12  text-center">
                                                <div class="form-group-sm">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, dbPsw%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtDBPassword" TextMode="Password"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel1">
                                                    <ProgressTemplate>
                                                        <div class="text-center" style="width: 100%;">
                                                            <img src="Imagenes/ajax-loader.gif" />&nbsp;<asp:Label runat="server" Text="<%$Resources:seguridad.language, espere%>"></asp:Label>
                                                        </div>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-6">
                                                <asp:Button runat="server" CssClass="btn btn-block btn-primary" Text="Save" ID="btnSaveServer" OnClick="btnSaveServer_Click" />
                                            </div>
                                            <div class="col-sm-3"></div>
                                        </div>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                            <div id="step-2" class="">
                                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_Db" runat="server"></asp:Literal>
                                        <div class="row">
                                            <div class="col-sm-6 text-center">
                                                <asp:RadioButton ID="rdbInitialScript" GroupName="Script" runat="server" CssClass="form-control  input-sm" Text="<%$Resources:login.language, script%>" Checked="true" />
                                            </div>
                                            <div class="col-sm-6 text-center">
                                                <asp:RadioButton ID="rdbBackup" GroupName="Script" runat="server" CssClass="form-control  input-sm" Text="<%$Resources:login.language, backup%>" />
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <div class="form-group">
                                                    <asp:FileUpload accept=".iac" runat="server" CssClass="form-control  input-sm" ID="flupScript" />
                                                </div>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-12">
                                                <asp:UpdateProgress ID="UpdateProgressRestore" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                                                    <ProgressTemplate>
                                                        <div class="text-center" style="width: 100%;">
                                                            <img src="Imagenes/ajax-loader.gif" />&nbsp;<asp:Label runat="server" Text="<%$Resources:seguridad.language, espere%>"></asp:Label>
                                                        </div>
                                                    </ProgressTemplate>
                                                </asp:UpdateProgress>
                                            </div>
                                        </div>
                                        <br />
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-6">
                                                <asp:Button runat="server" Text="Execute" CssClass="btn btn-block btn-primary" ID="btnUploadScript" OnClick="btnUploadScript_Click" />
                                            </div>
                                            <div class="col-sm-3"></div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnUploadScript" />
                                    </Triggers>
                                </asp:UpdatePanel>

                            </div>
                            <div id="step-3" class="">
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <asp:Literal ID="ltlMsg_User" runat="server"></asp:Literal>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, id%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtID_User"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, nombre%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtName_User"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, sex%>"></asp:Label>
                                                    <asp:DropDownList runat="server" CssClass="form-control input-sm" ID="ddlSex_User">
                                                        <asp:ListItem Text="Male" Value="male"></asp:ListItem>
                                                        <asp:ListItem Text="Female" Value="female"></asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="Puesto"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtPuesto_User"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, birthday%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" TextMode="Date" ID="txtBirthDay_User"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language,recruitment %>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" TextMode="Date" ID="txtRecruitment_user"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, user%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" ID="txtUser_User"></asp:TextBox>
                                                </div>
                                            </div>
                                            <div class="col-sm-6">
                                                <div class="form-group">
                                                    <asp:Label runat="server" Text="<%$Resources:login.language, password%>"></asp:Label>
                                                    <asp:TextBox runat="server" CssClass="form-control input-sm" TextMode="Password" ID="txtPsw_User"></asp:TextBox>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-sm-3"></div>
                                            <div class="col-sm-6">
                                                <asp:Button runat="server" CssClass="btn btn-block btn-primary" Text="Finish" ID="btnFinishConfig" OnClick="btnFinishConfig_Click" />
                                            </div>
                                            <div class="col-sm-3"></div>
                                        </div>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="btnFinishConfig" />
                                    </Triggers>
                                </asp:UpdatePanel>

                            </div>
                        </div>
                    </div>
                    <asp:Literal runat="server" Visible="false"></asp:Literal>
                </div>

            </div>
        </form>

    </div>
</body>



</html>
