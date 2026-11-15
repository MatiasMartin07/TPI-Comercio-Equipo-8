<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormUsuario.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-6 col-lg-5">

                <h4 class="text-center mb-4">Registro de Usuario</h4>

                <div class="row mb-3">
                    <div class="col-md-5 col-6">
                        <label class="form-label">ID</label>
                        <asp:TextBox ID="txtId" runat="server" placeholder="ID AutoGenerado" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col">
                        <label class="form-label">Nombre</label>
                        <asp:TextBox ID="txtNombre" CssClass="form-control" placeholder="Nombre" runat="server"  AutoPostBack="true" OnTextChanged="txtNombre_TextChanged"></asp:TextBox>
                        <asp:Label ID="lblErrorNombre" runat="server" CssClass="text-danger small"></asp:Label>
                    </div>
                    <div class="col">
                        <label class="form-label">Apellido</label>
                        <asp:TextBox ID="txtApellido" CssClass="form-control" placeholder="Apellido" runat="server" AutoPostBack="true" OnTextChanged="txtApellido_TextChanged" ></asp:TextBox>
                        <asp:Label ID="lblErrorApellido" runat="server" CssClass="text-danger small"></asp:Label>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col">
                        <asp:Label ID="lblNombreUsuario" runat="server" Text="Nombre Usuario" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtNombreUsuario" runat="server" CssClass="form-control" placeholder="Nombre Usuario" AutoPostBack="true" OnTextChanged="txtNombreUsuario_TextChanged" ></asp:TextBox>
                        <asp:Label ID="lblNUError" runat="server" CssClass="text-danger small"></asp:Label>
                    </div>
                </div>

                <div class="row g-3 mb-3">
                    <div class="col">
                        <asp:Label ID="lblPass" runat="server" Text="Contraseña" CssClass="form-label"></asp:Label>
                        <asp:TextBox ID="txtPass" runat="server" CssClass="form-control" placeholder="Contraseña" AutoPostBack="true" OnTextChanged="txtPass_TextChanged" ></asp:TextBox>
                        <asp:Label ID="lblPassError" runat="server" CssClass="text-danger small"></asp:Label>
                    </div>
                    <div class="col">
                        <asp:Label ID="lblRol" runat="server" Text="Rol" CssClass="form-label"></asp:Label>
                        <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-control">
                            <asp:ListItem Text="Seleccione..." Value=""></asp:ListItem>
                            <asp:ListItem Text="Administrador" Value="Administrador"></asp:ListItem>
                            <asp:ListItem Text="Vendedor" Value="Vendedor"></asp:ListItem>
                        </asp:DropDownList>
                        <!-- Validador para el DropDownList -->
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

            </div>
        </div>
        <div class="row justify-content-center mt-3">
            <div class="col-md-6 col-lg-5">
                <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                    <a href="Usuarios.aspx" class="btn btn-outline-secondary">Cancelar</a>
                    <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptar_Click" />
                    <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CssClass="btn btn-warning" OnClick="btnInactivar_Click"/>
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
                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" OnClick="btnEliminar_Click" />
                    </div>

                    <% if (confirmar) { %>
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
