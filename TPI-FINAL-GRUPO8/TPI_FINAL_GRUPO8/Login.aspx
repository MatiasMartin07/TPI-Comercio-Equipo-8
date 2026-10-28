<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

        <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-4 col-sm-6">
                <h3 class="text-center">Ingresar</h3>
                <div class="mb-3">
                    <asp:Label ID="lblUsuario" runat="server" Text="Usuario"></asp:Label>
                    <asp:TextBox ID="txtUsuario" runat="server" placeholder="Usuario" CssClass="form-control"
                        AutoPostBack="true" OnTextChanged="txtUsuario_TextChanged"
                        ></asp:TextBox>
                    <asp:Label ID="lblError" runat="server"></asp:Label>
                </div>

                <div class="mb-3">
                    <asp:Label ID="lblPass" runat="server" Text="Contraseña"></asp:Label>
                    <asp:TextBox ID="txtPass" runat="server" placeholder="Contraseña" CssClass="form-control" TextMode="Password"></asp:TextBox>
                </div>

                <div class="d-grid mt-4">
                    <asp:Button ID="btnIngresar" runat="server" Text="INICIAR SESIÓN" CssClass="btn btn-success" OnClick="btnIngresar_Click" />
                </div>
            </div>
        </div>
    </div>



</asp:Content>
