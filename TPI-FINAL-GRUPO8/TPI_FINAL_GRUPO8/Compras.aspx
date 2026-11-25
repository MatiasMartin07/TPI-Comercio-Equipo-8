<%@ Page Title="Compras" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Compras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="con-costados banner-modulo d-flex align-items-center
    justify-content-between gap-3 bg-primary bg-opacity-10
    border border-primary border-opacity-25 rounded
    p-4 p-xl-5 mb-4">
        <div>
            <h1 class="h2 fw-semibold mb-2">Compras</h1>
            <p class="text-secondary mb-0">
                Consultá las compras registradas y sus detalles.
       
            </p>
        </div>
        <span class="display-3 flex-shrink-0" aria-hidden="true">🛒</span>
    </div>

    <div class="d-flex justify-content-end mb-3">
        <asp:HyperLink ID="lnkAgregarCompra" runat="server"
            NavigateUrl="~/FormCompra.aspx"
            CssClass="btn btn-primary">
        + Nueva compra
    </asp:HyperLink>
    </div>

    <div class="table-responsive border rounded listado-catalogo">
        <asp:GridView ID="gvCompras" runat="server"
            AutoGenerateColumns="false"
            ShowHeaderWhenEmpty="true"
            DataKeyNames="IdCompra"
            CssClass="table table-striped align-middle"
            GridLines="None"
            EmptyDataText="Todavía no hay compras registradas.">

            <Columns>
                <asp:BoundField DataField="IdCompra" HeaderText="N.º de compra" />

                <asp:BoundField DataField="Fecha"
                    HeaderText="Fecha"
                    DataFormatString="{0:dd/MM/yyyy}" />

                <asp:TemplateField HeaderText="Proveedor">
                    <ItemTemplate>
                        <%# Eval("Proveedor.RazonSocial") %>
                    </ItemTemplate>
                </asp:TemplateField>

                <asp:BoundField DataField="Total"
                    HeaderText="Total"
                    DataFormatString="{0:N2}" />

                <asp:HyperLinkField HeaderText="Detalle"
                    Text="Ver detalle"
                    DataNavigateUrlFields="IdCompra"
                    DataNavigateUrlFormatString="~/DetalleCompra.aspx?idCompra={0}" />
            </Columns>
        </asp:GridView>
    </div>

</asp:Content>
