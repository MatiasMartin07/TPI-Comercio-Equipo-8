<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormProveedor.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormProveedor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">
        <div>
            <h2 class="h5 fw-semibold mb-3">Datos del proveedor</h2>
            <p class="text-secondary mb-0">Cargá o actualizá los datos del proveedor.</p>
        </div>
        <span class="display-3 flex-shrink-0" aria-hidden="true">🚚</span>
    </div>

    <div class="container mt-5">
        <div class="row justify-content-center">

            <div class="col-md-8 col-lg-7">


                <section class="border rounded p-3 p-lg-4">
                    <h2 class="h5 fw-semibold mb-3">Datos generales</h2>


                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">ID</label>
                            <asp:TextBox ID="txtId" runat="server" placeholder="ID AutoGenerado" CssClass="form-control" Style="max-width: none;" Enabled="false"></asp:TextBox>
                            <asp:Label ID="lblIdError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Código</label>
                            <asp:TextBox ID="txtCodigo" runat="server" placeholder="Código" CssClass="form-control" Style="max-width: none;" OnTextChanged="txtCodigo_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblCodigoError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label class="form-label">Razón Social</label>
                            <asp:TextBox ID="txtRazonSocial" CssClass="form-control" Style="max-width: none;" placeholder="Razón Social" runat="server" OnTextChanged="txtRazonSocial_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblErrorRazonSocial" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">CUIT</label>
                            <asp:TextBox ID="txtCuit" CssClass="form-control" Style="max-width: none;" placeholder="CUIT sin guiones" runat="server" OnTextChanged="txtCuit_TextChanged"></asp:TextBox>
                            <asp:Label ID="lblErrorCuit" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <div class="row g-3 mb-4">
                        <div class="col-md-6">
                            <label class="form-label">Teléfono</label>
                            <asp:TextBox ID="txtTelefono" runat="server" CssClass="form-control" Style="max-width: none;" placeholder="Ej: 11-1234-5678"></asp:TextBox>
                            <asp:Label ID="lblErrorTelefono" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Correo Electrónico</label>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" Style="max-width: none;" placeholder="Ej: proveedores@gmail.com"></asp:TextBox>
                            <asp:Label ID="lblEmailError" runat="server" CssClass="text-danger small"></asp:Label>
                        </div>
                    </div>

                    <hr class="my-4" />

                    <div class="d-flex flex-wrap gap-2 pt-3">
                        <div>
                            <asp:Button ID="btnInactivar" runat="server" Text="Inactivar" CssClass="btn btn-warning me-2" OnClick="btnInactivar_Click" />
                            <a href="Proveedores.aspx" class="btn btn-outline-secondary me-2">Cancelar</a>
                            <asp:Button ID="btnAceptar" runat="server" Text="Aceptar" CssClass="btn btn-success" OnClick="btnAceptar_Click" />
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
                                        ¿Confirma la Inactivación?
                                    </label>
                                </div>
                                <asp:Button ID="btnConfirma" runat="server" Text="Sí, Inactivar" CssClass="btn btn-sm btn-danger" OnClick="btnConfirma_Click" />
                            </div>
                            <% } %>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </section>
            </div>
        </div>
    </div>
</asp:Content>
