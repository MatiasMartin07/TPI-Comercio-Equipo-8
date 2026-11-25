<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormUsuario.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-7">

            <div class="card shadow-sm">
                <div class="card-body p-4">
                    <h4 class="text-center mb-4">Registro de Usuario</h4>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">ID</label>
                            <asp:TextBox ID="txtId" runat="server" placeholder="ID AutoGenerado" CssClass="form-control" Enabled="false"></asp:TextBox>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Nombre</label>
                            <asp:TextBox ID="txtNombre" CssClass="form-control" placeholder="Nombre" runat="server" AutoPostBack="true" OnTextChanged="txtNombre_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblErrorNombre" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label fw-bold">Apellido</label>
                            <asp:TextBox ID="txtApellido" CssClass="form-control" placeholder="Apellido" runat="server" AutoPostBack="true" OnTextChanged="txtApellido_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblErrorApellido" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <asp:Label ID="lblNombreUsuario" runat="server" Text="Nombre Usuario" CssClass="form-label fw-bold"></asp:Label>
                            <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control" placeholder="Nombre Usuario" AutoPostBack="true" OnTextChanged="txtNombreUsuario_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblNUError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                        <div class="col-md-6">
                            <asp:Label ID="lblPass" runat="server" Text="Contraseña" CssClass="form-label fw-bold"></asp:Label>
                            <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" placeholder="Contraseña" AutoPostBack="true" OnTextChanged="txtPass_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblPassError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <asp:Label ID="lblRol" runat="server" Text="Rol" CssClass="form-label fw-bold"></asp:Label>
                            <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select">
                                <asp:ListItem Text="Seleccione..." Value=""></asp:ListItem>
                                <asp:ListItem Text="Administrador" Value="Administrador"></asp:ListItem>
                                <asp:ListItem Text="Vendedor" Value="Vendedor"></asp:ListItem>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator
                                ID="rfvRol"
                                runat="server"
                                ControlToValidate="ddlRol"
                                InitialValue=""
                                ErrorMessage="Por favor seleccione un rol."
                                CssClass="text-danger small"
                                Display="Dynamic">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CssClass="btn btn-warning me-2" OnClick="btnInactivar_Click" CausesValidation="false" />
                            <a href="Usuarios.aspx" class="btn btn-outline-secondary me-2">Cancelar</a>
                            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptar_Click" />
                        </div>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>

</asp:Content>
