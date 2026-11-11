<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormCategoria.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormCategoria" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 id="tituloCategoria" runat="server">Nueva categoría</h1>
    <div class="row">
        <div class="col-md-4">
            <div class="mb-3">
                <asp:Label ID="lblNombre" runat="server"
                    Text="Nombre"
                    AssociatedControlID="txtNombre" />
                <asp:TextBox ID="txtNombre" runat="server"
                    CssClass="form-control"
                    MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                    ControlToValidate="txtNombre"
                    ErrorMessage="Ingresá el nombre de la categoría."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Categoria" />
            </div>
            <div id="accionesGuardar" runat="server" class="d-flex gap-2">
                <asp:Button ID="btnGuardar" runat="server"
                    Text="Guardar"
                    CssClass="btn btn-primary"
                    ValidationGroup="Categoria"
                    OnClick="btnGuardar_Click" />
                <a href="Categorias.aspx" class="btn btn-secondary">Cancelar</a>
            </div>
            <div class="mt-3">
                <asp:Button ID="btnDesactivar" runat="server"
                    Text="Desactivar categoría"
                    CssClass="btn btn-outline-danger"
                    CausesValidation="false"
                    Visible="false"
                     OnClick="btnDesactivar_Click"/>

                <asp:Button ID="btnReactivar" runat="server"
                    Text="Reactivar categoría"
                    CssClass="btn btn-outline-success"
                    CausesValidation="false"
                    Visible="false"
                    OnClick="btnReactivar_Click"/>
            </div>
            <asp:Panel ID="pnlConfirmarDesactivacion" runat="server"
                CssClass="mt-3" Visible="false">
                <p class="mb-2">¿De verdad querés desactivar esta categoría?</p>
                <asp:Button ID="btnConfirmarDesactivacion" runat="server"
                    Text="Sí, desactivar"
                    CssClass="btn btn-danger"
                    CausesValidation="false"
                    OnClick="btnConfirmarDesactivacion_Click"/>

                <asp:Button ID="btnCancelarDesactivacion" runat="server"
                    Text="No, cancelar"
                    CssClass="btn btn-outline-secondary"
                    CausesValidation="false"
                    OnClick="btnCancelarDesactivacion_Click" />
            </asp:Panel>
        </div>
    </div>
</asp:Content>
