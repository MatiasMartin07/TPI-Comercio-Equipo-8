<%@ Page Title="Marca" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormMarca.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormMarca" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 id="tituloMarca" runat="server">Nueva marca</h1>

    <div class="row">
        <div class="col-md-4">
            <div class="mb-3">
                <asp:Label ID="lblNombre" runat="server"
                    Text="Nombre" AssociatedControlID="txtNombre" />

                <asp:TextBox ID="txtNombre" runat="server"
                    CssClass="form-control" MaxLength="100" />

                <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                    ControlToValidate="txtNombre"
                    ErrorMessage="Ingrese el nombre de la marca."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Marca" />
            </div>

            <div class="mt-3 d-flex justify-content-between align-items-center gap-3 flex-wrap">
                <div>
                    <asp:Button ID="btnDesactivar" runat="server"
                        Text="Desactivar marca"
                        CssClass="btn btn-outline-danger"
                        CausesValidation="false"
                        Visible="false" OnClick="btnDesactivar_Click" />

                    <asp:Button ID="btnReactivar" runat="server"
                        Text="Reactivar marca"
                        CssClass="btn btn-outline-success"
                        CausesValidation="false"
                        Visible="false"
                        OnClick="btnReactivar_Click"/>
                </div>
                <div id="accionesGuardar" runat="server" class="d-flex gap-2">
                    <asp:Button ID="btnGuardar" runat="server"
                        Text="Guardar"
                        CssClass="btn btn-primary"
                        ValidationGroup="Marca"
                        OnClick="btnGuardar_Click" />
                    <a href="Marcas.aspx" class="btn btn-secondary">Cancelar</a>
                </div>
            </div>
            <asp:Panel ID="pnlConfirmarDesactivacion" runat="server" CssClass="mt-3" Visible="false">
                <p class="mb-2">¿De verdad querés desactivar esta marca?</p>
                <asp:Button ID="btnConfirmarDesactivacion" runat="server"
                    Text="Sí, desactivar"
                    CssClass="btn btn-danger"
                    CausesValidation="false"
                    OnClick="btnConfirmarDesactivacion_Click"/>

                <asp:Button ID="btnCancelarDesactivacion" runat="server"
                    Text="No, cancelar"
                    CssClass="btn btn-outline-secondary"
                    CausesValidation="false" OnClick="btnCancelarDesactivacion_Click"/>
            </asp:Panel>
        </div>
    </div>
</asp:Content>
