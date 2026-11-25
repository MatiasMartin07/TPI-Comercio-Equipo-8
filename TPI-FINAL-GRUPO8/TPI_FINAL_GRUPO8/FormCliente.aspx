<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormCliente.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormCliente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados banner-modulo d-flex align-items-center
        justify-content-between gap-3 bg-primary bg-opacity-10
        border border-primary border-opacity-25 rounded
        p-4 p-xl-5 mb-4">

        <div>
            <h1 class="h2 fw-semibold mb-2">Datos del cliente</h1>
            <p class="text-secondary mb-0">
                Completá los datos para registrar o modificar un cliente.
           
            </p>
        </div>

        <span class="display-3 flex-shrink-0" aria-hidden="true">👥</span>
    </div>

    <section class="border rounded p-3 p-lg-4">

        <h2 class="h4 mb-4">Datos generales</h2>

        <div class="row g-3">

            <div class="col-12 col-md-4">
                <asp:Label runat="server"
                    Text="ID"
                    AssociatedControlID="txtId"
                    CssClass="form-label" />

                <asp:TextBox ID="txtId" runat="server"
                    placeholder="ID autogenerado"
                    CssClass="form-control"
                    Style="max-width: none;" />

                <asp:Label ID="lblIdError" runat="server"
                    CssClass="text-danger small" />
            </div>

            <div class="col-12 col-md-8">
                <asp:Label runat="server"
                    Text="DNI o CUIL"
                    AssociatedControlID="txtDni"
                    CssClass="form-label" />

                <asp:TextBox ID="txtDni" runat="server"
                    placeholder="Ingresá el DNI o CUIL"
                    CssClass="form-control"
                    Style="max-width: none;"
                    TextMode="Number"
                    min="0"
                    step="1"
                    OnTextChanged="txtDni_TextChanged"
                    AutoPostBack="true" />

                <asp:Label ID="lblDniError" runat="server"
                    CssClass="text-danger small" />
            </div>

            <div class="col-12 col-md-6">
                <asp:Label runat="server"
                    Text="Nombre"
                    AssociatedControlID="txtNombre"
                    CssClass="form-label" />

                <asp:TextBox ID="txtNombre" runat="server"
                    placeholder="Nombre"
                    CssClass="form-control"
                    Style="max-width: none;"
                    OnTextChanged="txtNombre_TextChanged"
                    AutoPostBack="true" />

                <asp:Label ID="lblErrorNombre" runat="server"
                    CssClass="text-danger small" />
            </div>

            <div class="col-12 col-md-6">
                <asp:Label runat="server"
                    Text="Apellido"
                    AssociatedControlID="txtApellido"
                    CssClass="form-label" />

                <asp:TextBox ID="txtApellido" runat="server"
                    placeholder="Apellido"
                    CssClass="form-control"
                    Style="max-width: none;"
                    OnTextChanged="txtApellido_TextChanged"
                    AutoPostBack="true" />

                <asp:Label ID="lblErrorApellido" runat="server"
                    CssClass="text-danger small" />
            </div>

            <div class="col-12">
                <asp:Label runat="server"
                    Text="Correo electrónico"
                    AssociatedControlID="txtEmail"
                    CssClass="form-label" />

                <asp:TextBox ID="txtEmail" runat="server" placeholder="Ej.: sonia@gmail.com" CssClass="form-control"
                    Style="max-width: none;"
                    TextMode="Email"
                    OnTextChanged="txtEmail_TextChanged"
                    AutoPostBack="true" />

                <asp:Label ID="lblEmailError" runat="server"
                    CssClass="text-danger small" />
            </div>

        </div>

        <div class="d-flex flex-wrap justify-content-end gap-2 pt-4">
            <a href="Clientes.aspx" class="btn btn-outline-secondary">Cancelar
            </a>

            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptar_Click" />

            <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CssClass="btn btn-warning" OnClick="btnInactivar_Click" />
        </div>

    </section>

</asp:Content>
