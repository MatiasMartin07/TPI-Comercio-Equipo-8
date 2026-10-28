<%@ Page Title="Productos" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Productos.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Productos" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h1>Lista de productos</h1>

    <asp:GridView ID="gvProductos" runat="server"
        AutoGenerateColumns="false"
        ShowHeaderWhenEmpty="true"
        CssClass="table table-striped"
        EmptyDataText="No hay productos para mostrar.">
        <Columns>
            <%--<asp:BoundField DataField="IdProducto" HeaderText="ID" />--%>
            <asp:BoundField DataField="Nombre" HeaderText="Nombre" />
            <%--<asp:BoundField DataField="Marca.Nombre" HeaderText="Marca" />--%>
            <%--<asp:BoundField DataField="Categoria.Nombre" HeaderText="Categoría" />--%>
            <asp:BoundField DataField="StockActual" HeaderText="Stock actual" />
            <asp:BoundField DataField="StockMinimo" HeaderText="Stock mínimo" />
            <asp:BoundField DataField="PorcentajeGanancia" HeaderText="% Ganancia" />
            <asp:BoundField DataField="UltimoPrecioCompra" HeaderText="Último precio de compra" />
            <%--<asp:CheckBoxField DataField="Activo" HeaderText="Activo" />--%>
        </Columns>
    </asp:GridView>

</asp:Content>
