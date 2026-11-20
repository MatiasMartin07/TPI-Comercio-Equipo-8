<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormCompra.aspx.cs" Inherits="TPI_FINAL_GRUPO8.FormCompras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <h1 class="h3 mb-4">Nueva compra</h1>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h5 mb-3">Datos generales</h2>

                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label" for="ddlProveedor">Proveedor</label>
                        <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccione un proveedor" Value="" />
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label" for="txtFechaCompra">Fecha</label>
                        <asp:TextBox ID="txtFechaCompra" runat="server" TextMode="Date" CssClass="form-control" />
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h5 mb-3">Agregar productos</h2>

                <div class="row g-3 align-items-end">
                    <div class="col-md-5">
                        <label class="form-label" for="ddlProducto">Producto</label>
                        <asp:DropDownList ID="ddlProducto" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Seleccione un producto" Value="" />
                        </asp:DropDownList>
                    </div>

                    <div class="col-md-2">
                        <label class="form-label" for="txtCantidad">Cantidad</label>
                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="form-control" />
                    </div>

                    <div class="col-md-3">
                        <label class="form-label" for="txtPrecioUnitario">
                            Precio unitario                                              
                        </label>
                        <asp:TextBox ID="txtPrecioUnitario" runat="server"
                            CssClass="form-control" />
                    </div>

                    <div class="col-md-2">
                        <asp:Button ID="btnAgregarProducto" runat="server" Text="Agregar producto" CssClass="btn btn-outline-primary w-100" OnClick="btnAgregarProducto_Click" />
                    </div>
                </div>

                <asp:Label ID="lblErrorCompra" runat="server" CssClass="text-danger d-block mt-3" />
            </div>
        </div>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <h2 class="h5 mb-3">Detalle de la compra</h2>

                <asp:GridView ID="gvDetalleCompra" runat="server" AutoGenerateColumns="false" CssClass="table table-striped align-middle" EmptyDataText="Todavía no agregaste productos.">

                    <Columns>
                        <asp:TemplateField HeaderText="Producto">
                            <ItemTemplate>
                                <%# Eval("Producto.Nombre") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField DataField="Cantidad" HeaderText="Cantidad" />

                        <asp:BoundField DataField="PrecioUnitario" HeaderText="Precio unitario" DataFormatString="{0:N2}" />

                        <asp:BoundField DataField="SubTotal" HeaderText="SubTotal" DataFormatString="{0:N2}" />
                    </Columns>
                </asp:GridView>

                <div class="text-end fw-bold">
                    Total:                                       
                    <asp:Label ID="lblTotalCompra" runat="server" Text="0,00" />
                </div>
            </div>
        </div>

        <div class="d-flex justify-content-end gap-2 mb-4">
            <asp:HyperLink ID="lnkCancelar" runat="server" NavigateUrl="~/Compras.aspx" CssClass="btn btn-outline-secondary" OnClick="lnkCancelar_Click">
                Cancelar
            </asp:HyperLink>
            <asp:Button ID="btnConfirmarCompra" runat="server" Text="Confirmar compra" CssClass="btn btn-success" OnClick="btnConfirmarCompra_Click" />
        </div>
    </div>

</asp:Content>
