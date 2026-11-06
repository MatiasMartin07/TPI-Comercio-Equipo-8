<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormProveedor.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormProveedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-5">
        <div class="row justify-content-center">
            
            <div class="col-md-8 col-lg-7">

                
                <div class="card shadow-sm">
                    <div class="card-body p-4">
                        <h4 class="text-center mb-4">Registro de Proveedor</h4>

                        
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">ID</label>
                                <asp:TextBox ID="txtId" runat="server" placeholder="ID AutoGenerado" CssClass="form-control" Enabled="false"></asp:TextBox>
                                <asp:Label ID="lblIdError" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Código</label>
                                <asp:TextBox ID="txtCodigo" runat="server" placeholder="Código" CssClass="form-control" OnTextChanged="txtCodigo_TextChanged" AutoPostBack="true"></asp:TextBox>
                                <asp:Label ID="lblCodigoError" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                        </div>

                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Razón Social</label>
                                <asp:TextBox ID="txtRazonSocial" CssClass="form-control" placeholder="Razón Social" runat="server" OnTextChanged="txtRazonSocial_TextChanged" AutoPostBack="true"></asp:TextBox>
                                <asp:Label ID="lblErrorRazonSocial" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">CUIT</label>
                                <asp:TextBox ID="txtCuit" CssClass="form-control" placeholder="CUIT sin guiones" runat="server" OnTextChanged="txtCuit_TextChanged" AutoPostBack="true"></asp:TextBox>
                                <asp:Label ID="lblErrorCuit" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                        </div>

                        <div class="row g-3 mb-4">
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Teléfono</label>
                                <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" placeholder="Ej: 11-1234-5678" AutoPostBack="true"></asp:TextBox>
                                <asp:Label ID="lblErrorTelefono" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                            <div class="col-md-6">
                                <label class="form-label fw-bold">Correo Electrónico</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Ej: proveedores@gmail.com" AutoPostBack="true"></asp:TextBox>
                                <asp:Label ID="lblEmailError" runat="server" CssClass="text-danger small"></asp:Label>
                            </div>
                        </div>

                        <hr class="my-4" />

                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CssClass="btn btn-warning me-2" />

                                <asp:UpdatePanel ID="UpdatePanel1" runat="server" RenderMode="Inline">
                                    <ContentTemplate>
                                        <asp:Button ID="btnEliminar" runat="server" Text="Eliminar" CssClass="btn btn-danger" />
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>

                            <div>
                                <a href="Proveedores.aspx" class="btn btn-outline-secondary me-2">Cancelar</a>
                                <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" />
                            </div>
                        </div>

                        <asp:UpdatePanel ID="UpdatePanelConfirmacion" runat="server">
                            <ContentTemplate>
                                <% if (confirmar)
                                { %>
                                <div class="alert alert-danger mt-4 d-flex justify-content-between align-items-center">
                                    <div class="form-check">
                                        <asp:CheckBox ID="cbcConfirma" runat="server" CssClass="form-check-input" />
                                        <label class="form-check-label ms-1 text-danger fw-bold" for="<%= cbcConfirma.ClientID %>">
                                            ¿Confirma la Eliminación?
                                        </label>
                                    </div>
                                    <asp:Button ID="btnConfirma" runat="server" Text="Sí, Eliminar" CssClass="btn btn-sm btn-danger" />
                                </div>
                                <% } %>
                            </ContentTemplate>
                        </asp:UpdatePanel>

                    </div>
                </div>

            </div>
        </div>
    </div>

</asp:Content>
