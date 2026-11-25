<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormCliente.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormCliente" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">

            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h4 class="text-center mb-4">Registro de Cliente</h4>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">ID</label>
                            <asp:TextBox ID="txtId" runat="server" placeholder="ID AutoGenerado" CssClass="form-control"></asp:TextBox>
                            <asp:Label ID="lblIdError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>

                        <div class="col-md-6">
                            <label class="form-label fw-bold">DNI o CUIL</label>
                            <asp:TextBox ID="txtDni" runat="server" placeholder="DNI o CUIT" CssClass="form-control" TextMode="Number" min="0" step="1" OnTextChanged="txtDni_TextChanged" AutoPostBack="true"></asp:TextBox>
                            <asp:Label ID="lblDniError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control" placeholder="Nombre" runat="server" OnTextChanged="txtNombre_TextChanged" AutoPostBack="true"></asp:TextBox>
                            <asp:Label ID="lblErrorNombre" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Apellido</label>
                            <asp:TextBox ID="txtApellido" CssClass="form-control" placeholder="Apellido" runat="server" OnTextChanged="txtApellido_TextChanged" AutoPostBack="true"></asp:TextBox>
                            <asp:Label ID="lblErrorApellido" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Correo Electrónico</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Ej: sonia@gmail.com" OnTextChanged="txtEmail_TextChanged" TextMode="Email" AutoPostBack="true"></asp:TextBox>
                            <asp:Label ID="lblEmailError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CssClass="btn btn-warning me-2" OnClick="btnInactivar_Click" />
                            <a href="Clientes.aspx" class="btn btn-outline-secondary me-2">Cancelar</a>
                            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptar_Click" />
                        </div>
                    </div>

                    <asp:Label ID="lblError" runat="server" CssClass="text-danger small d-block mt-3"></asp:Label>

                </div>
            </div>

        </div>
    </div>
</div>



</asp:Content>
