using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Web;
using System.Web.UI;

namespace slnCAI
{
    public class ServerSocket
    {
        public static byte[] buffer { set; get; }
        public static List<Socket> lstClientes { set; get; }
        public static Socket serverSocket { set; get; }

        public static List<string> lstIP { set; get; }
        public static List<string> lstPC { set; get; }
        public static List<string> lstlog { set; get; }


        public static void SetupServer()
        {
            lstIP = new List<string>();
            lstPC = new List<string>();
            lstlog = new List<string>();
            buffer = new byte[1024];
            lstClientes = new List<Socket>();
            if (serverSocket == null)
            {
                serverSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                
            }
            else
            {
                if (!serverSocket.Connected)
                {
                    serverSocket = new Socket(AddressFamily.InterNetwork, SocketType.Stream, ProtocolType.Tcp);
                    lstlog.Add("Configurando Servidor...");
                    //Console.WriteLine("Configurando Servidor...");
                    serverSocket.Bind(new IPEndPoint(IPAddress.Any, 100));
                    serverSocket.Listen(2);
                    serverSocket.BeginAccept(new AsyncCallback(AcceptCallback), null);
                }
            }
            
            

        }

        public static void AcceptCallback(IAsyncResult ar)
        {
            Socket socket = serverSocket.EndAccept(ar);
            lstClientes.Add(socket);
            lstIP.Add("" + IPAddress.Parse(((IPEndPoint)socket.RemoteEndPoint).Address.ToString()));
            //Console.WriteLine("Cliente Conectado");
            socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, new AsyncCallback(ReceiveCallback), socket);
            serverSocket.BeginAccept(new AsyncCallback(AcceptCallback), null);
        }

        public static void ReceiveCallback(IAsyncResult ar)
        {
            Socket socket = (Socket)ar.AsyncState;

            try
            {
                int received = socket.EndReceive(ar);
                byte[] databuf = new byte[received];
                Array.Copy(buffer, databuf, received);

                string text = Encoding.ASCII.GetString(databuf);



                if (text.ToLower() == "get time")
                {
                    Console.WriteLine("Text received: " + text);
                    SendText(DateTime.Now.ToLongTimeString(), socket);
                }
                else
                {
                    if (text.ToLower().Substring(0, 2) == "pc")
                    {
                        lstPC.Add(text.Substring(3));
                        lstlog.Add(text.Substring(3) + " Conectada");
                        //Console.WriteLine();
                    }
                    else
                    {
                        SendText("Invalid Request", socket);
                    }

                }
                socket.BeginReceive(buffer, 0, buffer.Length, SocketFlags.None, new AsyncCallback(ReceiveCallback), socket);
            }
            catch (Exception)
            {
                lstlog.Add("PC desconectada");
                lstIP.Remove("" + IPAddress.Parse(((IPEndPoint)socket.RemoteEndPoint).Address.ToString()));
                //Console.WriteLine("client disconnected");
                socket.Close();
                socket.Dispose();
            }
        }

        public static void SendText(string text, Socket socket)
        {
            byte[] data = Encoding.ASCII.GetBytes(text);
            socket.BeginSend(data, 0, data.Length, SocketFlags.None, new AsyncCallback(SendCallback), socket);
        }

        public static void SendCallback(IAsyncResult AR)
        {
            Socket socket = (Socket)AR.AsyncState;
            socket.EndSend(AR);
        }

    }
}