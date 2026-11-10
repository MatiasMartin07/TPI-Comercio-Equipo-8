<%@ Page Title="Marcas" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Marcas.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Marcas" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Label ID="lblError" runat="server"
    CssClass="text-danger d-block"
    role="alert" />

<div class="d-flex flex-wrap justify-content-between align-items-center gap-2 bg-light border border-bottom-0 rounded-top px-3 py-2">
    <h1 class="h4 mb-0">Lista de marcas</h1>

    <a href="FormMarca.aspx" class="btn btn-primary btn-sm">
        + Nueva marca
    </a>
</div>
    <asp:GridView ID="gvMarcas" runat="server"
        AutoGenerateColumns="false"
        ShowHeaderWhenEmpty="true"
        CssClass="table table-striped align-middle"
        EmptyDataText="No hay marcas para mostrar."
         OnRowCommand="gvMarcas_RowCommand">
        <Columns>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <asp:HyperLink ID="lnkEditar" runat="server"
                        Text="Editar"
                        NavigateUrl='<%# Eval("IdMarca", "FormMarca.aspx?id={0}") %>'
                        CssClass="btn btn-outline-primary btn-sm" />

                    <asp:Button ID="btnEliminar" runat="server"
                        Text="Eliminar"
                        CssClass="btn btn-outline-danger btn-sm ms-3"
                        CommandName="SolicitarEliminacion"
                        CommandArgument='<%# Eval("IdMarca") %>'
                        CausesValidation="false" />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:Panel ID="pnlConfirmarEliminacion" runat="server"
        ClientIDMode="Static"
        CssClass="modal fade"
        Visible="false"
        role="dialog"
        aria-labelledby="tituloEliminar">

        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h2 id="tituloEliminar" class="modal-title fs-5">
                        Eliminar marca
                    </h2>
                </div>

                <div class="modal-body">
                    <asp:Label ID="lblConfirmacion" runat="server" />
                </div>

                <div class="modal-footer justify-content-end">
                    <asp:Button ID="btnConfirmarEliminacion" runat="server"
                        Text="Aceptar"
                        CssClass="btn btn-danger"
                        CausesValidation="false"
                        OnClick="btnConfirmarEliminacion_Click"/>

                    <asp:Button ID="btnCancelarEliminacion" runat="server"
                        Text="Cancelar"
                        CssClass="btn btn-secondary"
                        CausesValidation="false"
                        OnClick="btnCancelarEliminacion_Click"/>
                </div>

            </div>
        </div>
    </asp:Panel>
</asp:Content>
