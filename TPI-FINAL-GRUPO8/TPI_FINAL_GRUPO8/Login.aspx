<%@ Page Title="Iniciar sesión" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados login-pagina py-4">

        <div class="login-tarjeta bg-white p-4 mx-auto">

            <h1 class="h4 fw-semibold text-center mb-2">Gestión Comercial</h1>
<p class="text-secondary text-center mb-4">
    Iniciá sesión para continuar.
</p>

            <div class="mb-3">
                <asp:Label ID="lblUsuario" runat="server"
                    Text="Usuario"
                    AssociatedControlID="txtUsuario"
                    CssClass="form-label" />

                <asp:TextBox ID="txtUsuario" runat="server"
                    placeholder="Ingresá tu usuario"
                    CssClass="form-control"
                    Style="max-width: none;"
                    AutoPostBack="true"
                    OnTextChanged="txtUsuario_TextChanged" />
            </div>

            <div class="mb-3">
                <asp:Label ID="lblPass" runat="server"
                    Text="Contraseña"
                    AssociatedControlID="txtPass"
                    CssClass="form-label" />

                <asp:TextBox ID="txtPass" runat="server"
                    placeholder="Ingresá tu contraseña"
                    CssClass="form-control"
                    Style="max-width: none;"
                    TextMode="Password" />
            </div>

            <asp:Label ID="lblError" runat="server"
                CssClass="text-danger small d-block mb-3" />

            <div class="d-grid mt-4">
                <asp:Button ID="btnIngresar" runat="server"
                    Text="Iniciar sesión"
                    CssClass="btn btn-primary py-2"
                    OnClick="btnIngresar_Click" />
            </div>

        </div>

    </div>

</asp:Content>
