<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="d-flex flex-wrap justify-content-between align-items-center gap-2 bg-light border border-bottom-0 rounded-top px-3 py-2">
        <h1 class="h4 mb-0">Lista de productos</h1>

        <a href="FormProducto.aspx" class="btn btn-primary btn-sm">+ Nuevo producto
        </a>
    </div>
    <div class="d-flex flex-wrap align-items-center gap-2 border border-bottom-0 bg-white px-3 py-2">
        <asp:Label runat="server" AssociatedControlID="txtFiltroProducto"
            CssClass="visually-hidden" Text="Buscar por nombre, marca o categoría" />
        <asp:TextBox ID="txtFiltroProducto" runat="server"
            CssClass="form-control form-control-sm"
            Style="max-width: 240px;"
            placeholder="Nombre, marca o categoría"
            AutoPostBack="true"
            OnTextChanged="txtFiltroProducto_TextChanged" />

        <asp:Label runat="server" AssociatedControlID="ddlEstadoProducto"
            CssClass="visually-hidden" Text="Filtrar por estado" />
        <asp:DropDownList ID="ddlEstadoProducto" runat="server"
            CssClass="form-select form-select-sm"
            Style="max-width: 150px;"
            AutoPostBack="true"
            OnSelectedIndexChanged="ddlEstadoProducto_SelectedIndexChanged">
            <asp:ListItem Text="Todos" Value="todos" />
            <asp:ListItem Text="Activos" Value="activos" />
            <asp:ListItem Text="Inactivos" Value="inactivos" />
        </asp:DropDownList>
    </div>
    <div class="table-responsive border rounded-bottom listado-catalogo">
        <asp:GridView ID="gvProductos" runat="server"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            CssClass="table table-striped align-middle"
            EmptyDataText="No hay productos para mostrar.">
            <EmptyDataRowStyle CssClass="listado-sin-resultados" />
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
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
