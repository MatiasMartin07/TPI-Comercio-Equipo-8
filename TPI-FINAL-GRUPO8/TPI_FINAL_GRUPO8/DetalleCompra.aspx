<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetalleCompra.aspx.cs" Inherits="TPI_FINAL_GRUPO8.DetalleCompra" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">
        <div>
            <h1 class="h2 fw-semibold mb-2">Detalle de la compra</h1>
            <p class="text-secondary mb-0">
                Consultá los productos, cantidades y precios registrados.
       
            </p>
        </div>
        <span class="display-3 flex-shrink-0" aria-hidden="true">🛒</span>
    </div>

    <div class="d-flex justify-content-end mb-3">
        <asp:HyperLink ID="lnkVolver" runat="server"
            NavigateUrl="~/Compras.aspx"
            CssClass="btn btn-outline-secondary">
        Volver a compras
    </asp:HyperLink>
    </div>

    <div class="table-responsive border rounded listado-catalogo">
        <asp:GridView ID="gvDetalleCompra" runat="server"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            CssClass="table table-striped align-middle"
            GridLines="None"
            EmptyDataText="Esta compra no tiene productos cargados.">

            <Columns>
                <asp:TemplateField HeaderText="Producto">
                    <ItemTemplate>
                        <%# Eval("Producto.Nombre") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />

                <asp:BoundField DataField="PrecioUnitario"
                    HeaderText="Precio unitario"
                    DataFormatString="{0:N2}" />

                <asp:BoundField DataField="SubTotal"
                    HeaderText="Subtotal"
                    DataFormatString="{0:N2}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>
