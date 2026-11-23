<%@ Page Title="Marca" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormMarca.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormMarca" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados">

        <!-- Banner compacto y centrado -->
        <div class="banner-modulo d-flex align-items-center
            justify-content-between gap-3 bg-primary bg-opacity-10
            border border-primary border-opacity-25 rounded p-4 p-xl-5">

            <div>
                <h1 id="tituloMarca" runat="server"
                    class="h2 fw-semibold mb-2">
                    Nueva marca
                </h1>

                <p class="text-secondary mb-0">
    Completá el nombre de la marca para mantener tu catálogo organizado.
</p>
            </div>

            <span class="display-3 flex-shrink-0" aria-hidden="true">🏷️</span>
        </div>

        <!-- Campo y acciones dentro de una tarjeta -->
        <div class="formulario-simple formulario-simple-datos border rounded shadow-sm p-4">

            <asp:Label ID="lblNombre" runat="server"
                Text="Nombre"
                CssClass="form-label"
                AssociatedControlID="txtNombre" />

            <asp:TextBox ID="txtNombre" runat="server"
                CssClass="form-control"
                Style="max-width: none;"
                MaxLength="100" />

            <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                ControlToValidate="txtNombre"
                ErrorMessage="Ingrese el nombre de la marca."
                CssClass="text-danger"
                Display="Dynamic"
                ValidationGroup="Marca" />

            <div class="d-flex flex-wrap justify-content-between
                align-items-center gap-3 mt-4">

                <div>
                    <asp:Button ID="btnDesactivar" runat="server"
                        Text="Desactivar marca"
                        CssClass="btn btn-outline-danger"
                        CausesValidation="false"
                        Visible="false"
                        OnClick="btnDesactivar_Click" />

                    <asp:Button ID="btnReactivar" runat="server"
                        Text="Reactivar marca"
                        CssClass="btn btn-outline-success"
                        CausesValidation="false"
                        Visible="false"
                        OnClick="btnReactivar_Click" />
                </div>

                <div id="accionesGuardar" runat="server"
                    class="d-flex flex-wrap gap-2 ms-auto">

                    <a href="Marcas.aspx"
                        class="btn btn-outline-secondary">
                        Cancelar
                    </a>

                    <asp:Button ID="btnGuardar" runat="server"
                        Text="Guardar marca"
                        CssClass="btn btn-primary"
                        ValidationGroup="Marca"
                        OnClick="btnGuardar_Click" />
                </div>
            </div>

            <asp:Panel ID="pnlConfirmarDesactivacion" runat="server"
                CssClass="alert alert-warning mt-3 mb-0"
                Visible="false">

                <p class="mb-2">
                    ¿De verdad querés desactivar esta marca?
                </p>

                <div class="d-flex flex-wrap gap-2">
                    <asp:Button ID="btnConfirmarDesactivacion" runat="server"
                        Text="Sí, desactivar"
                        CssClass="btn btn-danger"
                        CausesValidation="false"
                        OnClick="btnConfirmarDesactivacion_Click" />

                    <asp:Button ID="btnCancelarDesactivacion" runat="server"
                        Text="No, cancelar"
                        CssClass="btn btn-outline-secondary"
                        CausesValidation="false"
                        OnClick="btnCancelarDesactivacion_Click" />
                </div>
            </asp:Panel>

        </div>
    </div>

</asp:Content>
