<%@ Page Title="Producto" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormProducto.aspx.cs" Inherits="TPI_FINAL_GRUPO8.WebForm1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="con-costados banner-modulo d-flex align-items-center
        justify-content-between gap-3 bg-primary bg-opacity-10
        border border-primary border-opacity-25 rounded p-4 p-xl-5 mb-4">
        <div>
            <h1 id="tituloProducto" runat="server" class="h2 fw-semibold mb-2">Nuevo producto</h1>
            <p class="text-secondary mb-0">Completá los datos del producto y agregá su imagen.</p>
        </div>
        <span class="display-3 flex-shrink-0" aria-hidden="true">📦</span>
    </div>

    <div class="formulario-producto row g-4 align-items-start">
        <div class="col-12 col-lg-7">
            <section class="border rounded p-3 p-lg-4">
                <h2 class="h5 fw-semibold mb-3">Datos del producto</h2>
                <div class="row g-3">
                    <div class="col-12">
                        <asp:Label ID="lblNombre" runat="server" CssClass="form-label"
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
                    <div class="col-12 col-sm-6">
                        <asp:Label ID="lblMarca" runat="server" CssClass="form-label"
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
                    <div class="col-12 col-sm-6">
                        <asp:Label ID="lblCategoria" runat="server" CssClass="form-label"
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
                    <div class="col-12">
                        <h3 class="h6 fw-semibold border-top pt-3 mt-2 mb-0">Stock</h3>
                    </div>
                    <div class="col-12 col-sm-6">
                        <asp:Label ID="lblStockActual" runat="server" CssClass="form-label"
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
                    <div class="col-12 col-sm-6">
                        <asp:Label ID="lblStockMinimo" runat="server" CssClass="form-label"
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
                    <div class="col-12">
                        <h3 class="h6 fw-semibold border-top pt-3 mt-2 mb-0">Precio y ganancia</h3>
                    </div>
                    <div class="col-12 col-sm-6">
                        <asp:Label ID="lblUltimoPrecioCompra" runat="server" CssClass="form-label"
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
                    <div class="col-12 col-sm-6">
                        <asp:Label ID="lblPorcentajeGanancia" runat="server" CssClass="form-label"
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
                </div>
            </section>
        </div>
        <div class="col-12 col-lg-5">
            <section class="border rounded p-3 p-lg-4">
                <h2 class="h5 fw-semibold mb-3">Imagen del producto</h2>
                <div class="mb-3">
                    <asp:Label ID="lblUrlImagen" runat="server"
                        Text="URL de imagen"
                        AssociatedControlID="txtUrlImagen" CssClass="form-label" />

                    <asp:Panel runat="server"
                        CssClass="d-flex flex-wrap flex-sm-nowrap align-items-center gap-2"
                        DefaultButton="btnVerImagen">

                        <asp:TextBox ID="txtUrlImagen" runat="server"
                            CssClass="form-control flex-grow-1"
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
                <div class="mb-3">
                    <asp:Label runat="server"
                        Text="Imagen desde la PC"
                        AssociatedControlID="fuImagenProducto" CssClass="form-label" />

                    <asp:FileUpload ID="fuImagenProducto" runat="server"
                        CssClass="form-control"
                        accept="image/jpeg,image/png"
                        onchange="mostrarImagenSeleccionada(this)" />
                </div>
                <p class="small text-secondary mb-3">Formatos permitidos: JPG y PNG.</p>
                <h3 class="h6 mb-2">Vista previa</h3>
                <div class="producto-vista-previa border rounded bg-light overflow-hidden">
                    <asp:Image ID="imgProducto" runat="server"
                        CssClass="w-100 h-100"
                        Style="object-fit: contain;"
                        AlternateText="Imagen del producto"
                        ImageUrl="~/Imagenes/productoSinImagen.png" />
                </div>
            </section>
        </div>
        <div class="col-12">
            <div class="d-flex flex-wrap justify-content-between align-items-start gap-3 pt-3">
                <div>
                    <asp:Button ID="btnDesactivar" runat="server" Text="Desactivar producto" CssClass="btn btn-outline-danger" CausesValidation="false" Visible="false" OnClick="btnDesactivar_Click" />
                    <asp:Panel ID="pnlConfirmarDesactivacion" runat="server" CssClass="alert alert-warning mt-3 mb-0" Visible="false">
                        <p class="mb-2">¿De verdad querés desactivar este producto?</p>
                        <asp:Button ID="btnConfirmarDesactivacion" runat="server" Text="Sí, desactivar" CssClass="btn btn-danger" CausesValidation="false" OnClick="btnConfirmarDesactivacion_Click" />
                        <asp:Button ID="btnCancelarDesactivacion" runat="server" Text="No, cancelar" CssClass="btn btn-outline-secondary" CausesValidation="false" OnClick="btnCancelarDesactivacion_Click" />
                    </asp:Panel>
                    <asp:Button ID="btnReactivar" runat="server" Text="Reactivar producto" CssClass="btn btn-outline-success" CausesValidation="false" Visible="false" OnClick="btnReactivar_Click" />
                </div>
                <div class="d-flex flex-wrap gap-2 ms-auto">
                    <a href="Productos.aspx" class="btn btn-outline-secondary">Cancelar</a>
                    <asp:Button ID="btnGuardar" runat="server"
                        Text="Guardar producto" CssClass="btn btn-primary"
                        OnClick="btnGuardar_Click" ValidationGroup="Producto" />
                </div>
            </div>
        </div>
    </div>

    <script>
        function mostrarImagenSeleccionada(selector) {
            const archivo = selector.files[0];

            if (!archivo) {
                return;
            }

            const lector = new FileReader();

            lector.onload = function (evento) {
                const imagen = document.getElementById(
                    '<%= imgProducto.ClientID %>');

                imagen.src = evento.target.result;
            };

            lector.readAsDataURL(archivo);
        }
    </script>
</asp:Content>
