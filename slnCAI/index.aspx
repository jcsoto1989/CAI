<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="slnCAI.index" Culture="es-CR" UICulture="es-CR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .flex-container {
            display: flex;
            flex-wrap: wrap;
            /*background-color: DodgerBlue;*/
        }

            .flex-container > div {
                background-color: #f1f1f1;
                width: 200px;
                margin: 5px;
                text-align: center;
                border-radius: 5px;
                /*line-height: 50px;*/
                /*font-size: 30px;*/
            }

        .shadow {
            -webkit-box-shadow: inset 2px 2px 15px 2px rgba(0,0,0,1);
            -moz-box-shadow: inset 2px 2px 15px 2px rgba(0,0,0,1);
            box-shadow: inset 2px 2px 15px 2px rgba(0,0,0,1);
            background-color: #337ab7;
            color: #ffffff;
            border-radius: 5px;
        }

        .shadow1 {
            -webkit-box-shadow: inset 2px 2px 15px 2px rgba(0,0,0,1);
            -moz-box-shadow: inset 2px 2px 15px 2px rgba(0,0,0,1);
            box-shadow: inset 2px 2px 15px 2px rgba(0,0,0,1);
            background-color: #337ab7;
            color: #ffffff;
            border-radius: 5px;
        }

        .circle {
            border: 1px solid black;
            border-radius: 15px;
            padding: 4px;
            background-Color: #fff;
            font-weight: bold;
        }

        .Elipsis {
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
            max-width: 10vh;
            display: table-cell;
        }

        /* Popover */
        .popover {
            border: 1px solid #343341;
        }
        /* Popover Header */
        .popover-title {
            background-color: #343341;
            color: #FFFFFF;
            font-size: 12px;
            text-align: center;
            font-weight: bold;
        }
        /* Popover Body */
        .popover-content {
            background-color: #fff;
            color: navy;
            padding: 5px;
        }
        /* Popover Arrow */
        .arrow {
            border-color: #343341 !important;
            background-color: #343341 !important;
        }

        .containeri {
            position: relative;
            text-align: center;
            color: white;
        }

        .centeredi {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        @page {
            size: auto; /* auto is the initial value */
            /* this affects the margin in the printer settings */
            margin: 25mm 25mm 25mm 25mm;
        }
    </style>
    <script>
        $(document).ready(function () {
            $('[data-toggle="popover"]').popover();
        });

        function notifyMe(Titulo, Mensaje) {
            if (!window.Notification) {
                console.log('Browser does not support notifications.');
            } else {
                // check if permission is already granted
                if (Notification.permission === 'granted') {
                    // show notification here
                    var notify = new Notification(Titulo, {
                        body: Mensaje,
                        icon: 'https://bit.ly/2DYqRrh',
                    });
                } else {
                    // request permission from user
                    Notification.requestPermission().then(function (p) {
                        if (p === 'granted') {
                            // show notification here
                            var notify = new Notification('Hi there!', {
                                body: 'How are you doing?',
                                icon: 'https://bit.ly/2DYqRrh',
                            });
                        } else {
                            console.log('User blocked notifications.');
                        }
                    }).catch(function (err) {
                        console.error(err);
                    });
                }
            }
        }


    </script>

    <script type='text/javascript' src='https://www.gstatic.com/charts/loader.js'></script>
    <asp:Literal ID="ltlGrafico" runat="server"></asp:Literal>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid">
        <asp:UpdatePanel runat="server" ID="updatePanel"></asp:UpdatePanel>
        <div class="row">
            <div class="col-sm-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">Eventos</div>
                    <div class="panel-body" style="height: 51vh">
                        <asp:Calendar OnDayRender="Calendar1_DayRender" ID="Calendar1" runat="server" BorderColor="White" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="100%" NextPrevFormat="FullMonth" Width="100%" CaptionAlign="Top">
                            <DayHeaderStyle Font-Bold="True" Font-Size="10pt"></DayHeaderStyle>
                            <NextPrevStyle VerticalAlign="Middle" Font-Bold="True" Font-Size="8pt" ForeColor="#333333"></NextPrevStyle>
                            <OtherMonthDayStyle ForeColor="#999999"></OtherMonthDayStyle>
                            <SelectedDayStyle ForeColor="Black" CssClass="shadow1"></SelectedDayStyle>
                            <TitleStyle BackColor="White" Font-Bold="True" Font-Size="12pt" ForeColor="#333399"></TitleStyle>
                            <TodayDayStyle CssClass="circle" Font-Bold="true" ForeColor="#000066"></TodayDayStyle>
                            <WeekendDayStyle ForeColor="#d20000" Font-Bold="true" />
                        </asp:Calendar>
                    </div>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        <div class="form-inline">
                            <div class="form-group-sm">
                                <label>Uso Mensual:</label>
                                <asp:DropDownList ID="ddlMes" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlMes_SelectedIndexChanged" AutoPostBack="true">
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
                                <asp:DropDownList ID="ddlAnno" runat="server" CssClass="form-control input-sm" OnSelectedIndexChanged="ddlAnno_SelectedIndexChanged" AutoPostBack="true">
                                    <asp:ListItem Text="2020" Value="2020"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                    </div>
                    <div class="panel-body" style="height: 50vh; overflow-y: scroll; overflow-x: hidden;">
                        <asp:Literal ID="ltlUsoMensualSexo" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-sm-12">
                <div class="panel panel-primary">
                    <div class="panel-heading">
                        Estadisticas de Uso de Espacio
                    </div>
                    <div class="panel-body" style="height: 30vh">
                        <div id="curve_chart" style="width: 100%; height: 100%"></div>
                        <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
                        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
                    </div>
                </div>
            </div>
        </div>

    </div>

</asp:Content>
