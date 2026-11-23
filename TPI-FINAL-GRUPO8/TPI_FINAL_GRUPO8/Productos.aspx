<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">

        <div>
            <h1 class="h2 fw-semibold mb-2">Productos</h1>

            <p class="text-secondary mb-0">
                Administrá tu catálogo, consultá el stock
            y mantené actualizados tus productos.
       
            </p>
        </div>

        <span class="display-3 flex-shrink-0" aria-hidden="true">📦</span>
    </div>
    <div class="d-flex justify-content-end mb-3">
        <a href="FormProducto.aspx" class="btn btn-primary">+ Nuevo producto
    </a>
    </div>
    <div class="border border-bottom-0 rounded-top bg-light p-3">
        <div class="row g-3 align-items-end">

            <div class="col-12 col-md-8">
                <asp:Label runat="server"
                    AssociatedControlID="txtFiltroProducto"
                    CssClass="form-label"
                    Text="Buscar producto" />

                <asp:TextBox ID="txtFiltroProducto" runat="server"
                    CssClass="form-control"
                    Style="max-width: none;"
                    placeholder="Nombre, marca o categoría"
                    AutoPostBack="true"
                    OnTextChanged="txtFiltroProducto_TextChanged" />
            </div>

            <div class="col-12 col-md-4">
                <asp:Label runat="server"
                    AssociatedControlID="ddlEstadoProducto"
                    CssClass="form-label"
                    Text="Estado" />

                <asp:DropDownList ID="ddlEstadoProducto" runat="server"
                    CssClass="form-select"
                    Style="max-width: none;"
                    AutoPostBack="true"
                    OnSelectedIndexChanged="ddlEstadoProducto_SelectedIndexChanged">

                    <asp:ListItem Text="Todos" Value="todos" />
                    <asp:ListItem Text="Activos" Value="activos" />
                    <asp:ListItem Text="Inactivos" Value="inactivos" />
                </asp:DropDownList>
            </div>

        </div>
    </div>
    <div class="table-responsive border rounded-bottom listado-catalogo">
        <asp:GridView ID="gvProductos" runat="server"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            CssClass="table table-striped align-middle"
            EmptyDataText="No hay productos para mostrar.">
            <EmptyDataRowStyle CssClass="listado-sin-resultados" />
            <Columns>
                <asp:BoundField DataField="IdProducto" HeaderText="ID" />
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
                <asp:BoundField DataField="PorcentajeGanancia"
                    HeaderText="Ganancia"
                    DataFormatString="{0:0.##} %"
                    HeaderStyle-CssClass="text-center"
                    ItemStyle-CssClass="text-center text-nowrap" />

                <asp:BoundField DataField="UltimoPrecioCompra"
                    HeaderText="Último precio de compra"
                    DataFormatString="{0:C2}"
                    HeaderStyle-CssClass="text-center"
                    ItemStyle-CssClass="text-center text-nowrap" />
                <asp:TemplateField HeaderText="Estado">
                    <ItemTemplate>
                        <span class='<%# (bool)Eval("Activo")
            ? "badge bg-success bg-opacity-10 text-success px-2 py-2"
            : "badge bg-secondary bg-opacity-10 text-secondary px-2 py-2" %>'>

                            <%# (bool)Eval("Activo") ? "Activo" : "Inactivo" %>
        </span>
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
