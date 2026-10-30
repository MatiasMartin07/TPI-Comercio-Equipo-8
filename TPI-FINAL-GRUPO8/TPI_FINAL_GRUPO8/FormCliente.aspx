<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormCliente.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormCliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6 col-lg-5">

            <h4 class="text-center mb-4">Registro de Cliente</h4>

            <div class="row g-3 mb-3">
                <div class="col">
                    <label class="form-label">ID</label>
                    <asp:TextBox ID="txtId" runat="server" placeholder="ID AutoGenerado" CssClass="form-control" ></asp:TextBox>
                    <asp:Label ID="lblIdError" runat="server" CssClass="text-danger small"></asp:Label>
                </div>

                <div class="col">
                    <label class="form-label">DNI o CUIL</label>
                    <asp:TextBox ID="txtDni" runat="server" placeholder="DNI o CUIT" CssClass="form-control" TextMode="Number" OnTextChanged="txtDni_TextChanged" AutoPostBack="true" ></asp:TextBox>
                    <asp:Label ID="lblDniError" runat="server" CssClass="text-danger small"></asp:Label>
                </div>
            </div>

            <div class="row g-3 mb-3">
                <div class="col">
                    <label class="form-label">Nombre</label>
                    <asp:TextBox ID="txtNombre" CssClass="form-control" placeholder="Nombre" runat="server" OnTextChanged="txtNombre_TextChanged" AutoPostBack="true" ></asp:TextBox>
                    <asp:Label ID="lblErrorNombre" runat="server"></asp:Label>
                </div>
                <div class="col">
                    <label class="form-label">Apellido</label>
                    <asp:TextBox ID="txtApellido" CssClass="form-control" placeholder="Apellido" runat="server" OnTextChanged="txtApellido_TextChanged" AutoPostBack="true"></asp:TextBox>
                    <asp:Label ID="lblErrorApellido" runat="server"></asp:Label>

                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Correo Electrónico</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Ej: sonia@gmail.com" OnTextChanged="txtEmail_TextChanged" AutoPostBack="true"></asp:TextBox>
                <asp:Label ID="lblEmailError" runat="server" CssClass="text-danger small"></asp:Label>
            </div>

        </div>
    </div>

    <div class="row justify-content-center mt-3">
        <div class="col-md-6 col-lg-5">
            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                <a href="Clientes.aspx" class="btn btn-outline-secondary">Cancelar</a>
                <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptar_Click" />
                <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CssClass="btn btn-warning" OnClick="btnInactivar_Click" />
            </div>
        </div>
    </div>
</div>

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div class="container mt-3">
                <div class="row justify-content-center">
                    <div class="col-md-6 col-lg-5">
                        <div class="mb-3">
                            <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click"  />
                        </div>

                        <% if (confirmar)
                        { %>
                        <div class="mb-3">
                            <asp:CheckBox ID="cbcConfirma" runat="server" Text="¿Confirma la Eliminación?" />
                            <asp:Button ID="btnConfirma" runat="server" Text="Si, Eliminar" CssClass="btn btn-outline-danger" OnClick="btnConfirma_Click" />
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>


</asp:Content>
