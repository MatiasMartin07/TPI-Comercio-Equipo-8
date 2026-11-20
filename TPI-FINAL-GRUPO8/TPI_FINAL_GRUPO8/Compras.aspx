<%@ Page Title="Compras" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Compras.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Compras" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div>
                <h1 class="h3 mb-1">Compras</h1>
                <p class="text-muted mb-0">
                    Consulta de compras registradas
               
                </p>
            </div>
            <asp:HyperLink
                ID="lnkAgregarCompra" runat="server" NavigateUrl="~/FormCompra.aspx" CssClass="btn btn-success"> + Agregar compra
            </asp:HyperLink>
        </div>
        <div class="card shadow-sm">
            <div class="card-body">

                <asp:GridView
                    ID="gvCompras" runat="server" AutoGenerateColumns="false"
                    DataKeyNames="IdCompra" CssClass="table table-striped table-hover align-middle mb-0" GridLines="None" EmptyDataText="Todavía no hay compras registradas.">

                    <Columns>
                        <asp:BoundField DataField="IdCompra" HeaderText="N.º de compra" />

                        <asp:BoundField
                            DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}" />

                        <asp:TemplateField HeaderText="Proveedor">
                            <ItemTemplate>
                                <%# Eval("Proveedor.RazonSocial") %>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:BoundField
                            DataField="Total" HeaderText="Total" DataFormatString="{0:N2}" />
                        <asp:HyperLinkField HeaderText="Detalle" Text="Ver detalle" DataNavigateUrlFields="IdCompra" DataNavigateUrlFormatString="~/DetalleCompra.aspx?idCompra={0}" />
                    </Columns>

                </asp:GridView>

            </div>
        </div>

    </div>

</asp:Content>
