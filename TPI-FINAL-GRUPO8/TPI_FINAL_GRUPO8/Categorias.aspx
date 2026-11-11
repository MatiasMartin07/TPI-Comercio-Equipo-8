<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Categorias.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Categorias" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 bg-light border border-bottom-0 rounded-top px-3 py-2">
        <h1 class="h4 mb-0">Lista de categorías</h1>
        <a href="FormCategoria.aspx" class="btn btn-primary btn-sm">+ Nueva categoría</a>
    </div>
    <asp:GridView ID="gvCategorias" runat="server"
        AutoGenerateColumns="false"
        CssClass="table table-striped align-middle"
        EmptyDataText="No hay categorías para mostrar." OnRowCommand="gvCategorias_RowCommand">
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
                        NavigateUrl='<%# Eval("IdCategoria", "FormCategoria.aspx?id={0}") %>'
                        CssClass="btn btn-outline-primary btn-sm" />

                    <asp:Button ID="btnEliminar" runat="server"
                        Text="Eliminar"
                        CssClass="btn btn-outline-danger btn-sm ms-3"
                        CommandName="SolicitarEliminacion"
                        CommandArgument='<%# Eval("IdCategoria") %>'
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
                <h2 id="tituloEliminar" class="modal-title fs-5">Eliminar categoría</h2>
            </div>

            <div class="modal-body">
                <asp:Label ID="lblConfirmacion" runat="server" />
            </div>

            <div class="modal-footer">
                <asp:Button ID="btnConfirmarEliminacion" runat="server"
                    Text="Aceptar"
                    CssClass="btn btn-danger"
                    CausesValidation="false"
                     OnClick="btnConfirmarEliminacion_Click"/>

                <button type="button" class="btn btn-secondary"
                    data-bs-dismiss="modal">Cancelar</button>
            </div>
        </div>
    </div>
</asp:Panel>
</asp:Content>
