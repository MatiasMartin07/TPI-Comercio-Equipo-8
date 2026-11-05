<%@ Page Title="Producto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormProducto.aspx.cs" Inherits="TPI_FINAL_GRUPO8.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <h1 id="tituloProducto" runat="server">Nuevo producto</h1>
    <div class="row">
        <div class="col-md-4">

            <div class="mb-3">
                <asp:Label ID="lblNombre" runat="server"
                    Text="Nombre" AssociatedControlID="txtNombre" />
                <asp:TextBox ID="txtNombre" runat="server"
                    CssClass="form-control" MaxLength="100" />
                <asp:RequiredFieldValidator ID="rfvNombre" runat="server"
                    ControlToValidate="txtNombre"
                    ErrorMessage="Ingrese el nombre del producto."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Producto" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblMarca" runat="server"
                    Text="Marca" AssociatedControlID="ddlMarca" />
                <asp:DropDownList ID="ddlMarca" runat="server"
                    CssClass="form-select">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvMarca" runat="server"
                    ControlToValidate="ddlMarca"
                    InitialValue=""
                    ErrorMessage="Seleccione una marca."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Producto" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblCategoria" runat="server"
                    Text="Categoría" AssociatedControlID="ddlCategoria" />
                <asp:DropDownList ID="ddlCategoria" runat="server"
                    CssClass="form-select">
                </asp:DropDownList>
                <asp:RequiredFieldValidator ID="rfvCategoria" runat="server"
                    ControlToValidate="ddlCategoria"
                    InitialValue=""
                    ErrorMessage="Seleccione una categoría."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Producto" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblStockActual" runat="server"
                    Text="Stock actual" AssociatedControlID="txtStockActual" />
                <asp:TextBox ID="txtStockActual" runat="server"
                    CssClass="form-control" TextMode="Number"
                    min="0" step="1" />
                <asp:RequiredFieldValidator ID="rfvStockActual" runat="server"
                    ControlToValidate="txtStockActual"
                    ErrorMessage="Ingrese el stock actual."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Producto" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblStockMinimo" runat="server"
                    Text="Stock mínimo" AssociatedControlID="txtStockMinimo" />
                <asp:TextBox ID="txtStockMinimo" runat="server"
                    CssClass="form-control" TextMode="Number"
                    min="0" step="1" />
                <asp:RequiredFieldValidator ID="rfvStockMinimo" runat="server"
                    ControlToValidate="txtStockMinimo"
                    ErrorMessage="Ingrese el stock mínimo."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Producto" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblUltimoPrecioCompra" runat="server"
                    Text="Último precio de compra"
                    AssociatedControlID="txtUltimoPrecioCompra" />
                <asp:TextBox ID="txtUltimoPrecioCompra" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvUltimoPrecioCompra" runat="server"
                    ControlToValidate="txtUltimoPrecioCompra"
                    ErrorMessage="Ingrese el último precio de compra."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Producto" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblPorcentajeGanancia" runat="server"
                    Text="Porcentaje de ganancia (%)"
                    AssociatedControlID="txtPorcentajeGanancia" />
                <asp:TextBox ID="txtPorcentajeGanancia" runat="server" CssClass="form-control" />
                <asp:RequiredFieldValidator ID="rfvPorcentajeGanancia" runat="server"
                    ControlToValidate="txtPorcentajeGanancia"
                    ErrorMessage="Ingrese el porcentaje de ganancia."
                    CssClass="text-danger"
                    Display="Dynamic"
                    ValidationGroup="Producto" />
            </div>
            <asp:Button ID="btnDesactivar" runat="server" Text="Desactivar producto" CssClass="btn btn-outline-danger" CausesValidation="false" Visible="false" OnClick="btnDesactivar_Click" />
            <asp:Panel ID="pnlConfirmarDesactivacion" runat="server" CssClass="mt-3" Visible="false">
                <p class="mb-2">¿De verdad querés desactivar este producto?</p>
                <asp:Button ID="btnConfirmarDesactivacion" runat="server" Text="Sí, desactivar" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnConfirmarDesactivacion_Click" />
                <asp:Button ID="btnCancelarDesactivacion" runat="server" Text="No, cancelar" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="btnCancelarDesactivacion_Click" />
            </asp:Panel>
            <asp:Button ID="btnReactivar" runat="server" Text="Reactivar producto" CssClass="btn btn-outline-success" CausesValidation="false" Visible="false" OnClick="btnReactivar_Click" />
        </div>

        <div class="col-md-4">
            <div class="mb-3">
                <asp:Label ID="lblUrlImagen" runat="server"
                    Text="URL de imagen"
                    AssociatedControlID="txtUrlImagen" />

                <asp:Panel runat="server"
                    CssClass="d-flex align-items-center gap-2"
                    DefaultButton="btnVerImagen">

                    <asp:TextBox ID="txtUrlImagen" runat="server"
                        CssClass="form-control"
                        MaxLength="2048"
                        AutoPostBack="true"
                        OnTextChanged="txtUrlImagen_TextChanged" />

                    <asp:Button ID="btnVerImagen" runat="server"
                        Text="Ver imagen"
                        CssClass="btn btn-outline-primary text-nowrap"
                        CausesValidation="false"
                        OnClick="txtUrlImagen_TextChanged" />

                </asp:Panel>
            </div>
            <h2>Vista previa</h2>
            <div class="border rounded bg-light overflow-hidden"
                style="height: 400px;">
                <asp:Image ID="imgProducto" runat="server"
                    CssClass="w-100 h-100"
                    Style="object-fit: contain;"
                    AlternateText="Imagen del producto"
                    Visible="false" />
            </div>
            <div class="mt-3 d-flex justify-content-end gap-2">
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="btn btn-primary" OnClick="btnGuardar_Click" ValidationGroup="Producto" />
                <a href="Productos.aspx" class="btn btn-secondary">Cancelar</a>
            </div>

        </div>
    </div>
    </div>
</asp:Content>
