<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="DetalleCompra.aspx.cs" Inherits="TPI_FINAL_GRUPO8.DetalleCompra" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 mb-1">Detalle de la compra</h1>
                <p class="text-muted mb-0">
                    Productos incluidos en la compra
                </p>
            </div>

            <asp:HyperLink ID="lnkVolver" runat="server" NavigateUrl="~/Compras.aspx" CssClass="btn btn-outline-secondary">
                Volver a compras
            </asp:HyperLink>
        </div>

        <div class="card shadow-sm">
            <div class="card-body">
                <asp:GridView ID="gvDetalleCompra" runat="server" AutoGenerateColumns="false" CssClass="table table-striped table-hover align-middle mb-0" GridLines="None" EmptyDataText="Esta compra no tiene productos cargados.">

                    <Columns>
                        <asp:TemplateField HeaderText="Producto">
                            <ItemTemplate>
                                <%# Eval("Producto.Nombre") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />

                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio unitario" DataFormatString="{0:N2}" />

                        <asp:BoundField DataField="SubTotal" HeaderText="Subtotal" DataFormatString="{0:N2}" />
                    </Columns>

                </asp:GridView>
            </div>
        </div>
    </div>

</asp:Content>
