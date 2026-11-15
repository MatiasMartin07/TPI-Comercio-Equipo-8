<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 bg-light border border-bottom-0 rounded-top px-3 py-2">
        <h1 class="h4 mb-0">Lista de productos</h1>

        <a href="FormProducto.aspx" class="btn btn-primary btn-sm">+ Nuevo producto
        </a>
    </div>
    <div class="table-responsive">
    <asp:GridView ID="gvProductos" runat="server"
        AutoGenerateColumns="false" OnRowCommand="gvProductos_RowCommand"
        ShowHeaderWhenEmpty="true"
        CssClass="table table-striped align-middle"
        EmptyDataText="No hay productos para mostrar.">
        <Columns>
            <%--<asp:BoundField DataField="IdProducto" HeaderText="ID" />--%>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <asp:TemplateField HeaderText="Marca">
                <ItemTemplate>
                    <%# Eval("Marca.Nombre") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Categoría">
                <ItemTemplate>
                    <%# Eval("Categoria.Nombre") %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="StockActual" HeaderText="Stock actual"
                HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
            <asp:BoundField DataField="StockMinimo" HeaderText="Stock mínimo"
                HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
            <asp:BoundField DataField="PorcentajeGanancia" HeaderText="% Ganancia"
                HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
            <asp:BoundField DataField="UltimoPrecioCompra" HeaderText="Último precio de compra"
                HeaderStyle-CssClass="text-center" ItemStyle-CssClass="text-center" />
            <asp:TemplateField HeaderText="Estado">
                <ItemTemplate>
                    <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Acciones" HeaderStyle-CssClass="ps-4"
                ItemStyle-CssClass="ps-4">
                <ItemTemplate>
                    <asp:HyperLink runat="server"
                        Text="Editar"
                        NavigateUrl='<%# Eval("IdProducto", "FormProducto.aspx?id={0}") %>'
                        CssClass="btn btn-outline-primary btn-sm" />
                    <asp:Button runat="server"
                        Text="Eliminar"
                        CssClass="btn btn-outline-danger btn-sm ms-3"
                        CausesValidation="false"
                        CommandName="SolicitarEliminacion"
                        CommandArgument='<%# Eval("IdProducto") %>' />
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    </div>
    <asp:Panel ID="pnlConfirmarEliminacion" runat="server"
        ClientIDMode="Static"
        CssClass="modal fade"
        Visible="false"
        role="dialog"
        aria-labelledby="tituloEliminar">

        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h2 id="tituloEliminar" class="modal-title fs-5">Eliminar producto
                </h2>
                </div>

                <div class="modal-body">
                    ¿Querés eliminar definitivamente este producto?
           
                </div>

                <div class="modal-footer justify-content-end">
                    <asp:Button ID="btnConfirmarEliminacion" runat="server" Text="Sí" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnConfirmarEliminacion_Click" />

                    <asp:Button ID="btnCancelarEliminacion" runat="server" Text="Cancelar" CssClass="btn btn-secondary" CausesValidation="false" OnClick="btnCancelarEliminacion_Click" />
                </div>

            </div>
        </div>
    </asp:Panel>

</asp:Content>
