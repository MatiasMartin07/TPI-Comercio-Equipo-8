<%@ Page Title="Inicio" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Inicio.aspx.cs" Inherits="TPI_FINAL_GRUPO8.Inicio" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="inicio-banner d-flex align-items-center justify-content-between gap-3
    bg-primary bg-opacity-10 border border-primary border-opacity-25
    rounded p-4 p-xl-5">

        <div>
            <h1 class="h2 fw-semibold mb-2">Bienvenida a Gestión Comercial
            </h1>
            <p class="text-secondary mb-0">
                Administrá tu catálogo, las compras y las ventas
                desde un solo lugar.
           
            </p>
        </div>

        <span class="display-3 flex-shrink-0" aria-hidden="true">🏪</span>
    </div>
    <div class="inicio-estadisticas row g-3 mt-5 mb-3">
        <div class="col-12 col-sm-8">
            <section class="border rounded p-3 h-100 bg-light">
                <h2 class="h5 fw-semibold mb-2">📦 Productos con menor stock</h2>

                <p class="small text-secondary mb-3">
                    Stock actual y mínimo · Unidades
           
                </p>

                <asp:Repeater ID="rptStock" runat="server">
                    <ItemTemplate>
                        <div class="inicio-stock-fila">
                            <span class="small"><%#: Eval("Nombre") %></span>

                            <div>
                                <div class="inicio-stock-medida">
                                    <div class="inicio-stock-pista">
                                        <div class="inicio-stock-barra bg-primary"
                                            style='width: <%#: Eval("AnchoActual") %>%'>
                                        </div>
                                    </div>
                                    <span><%#: Eval("StockActual") %></span>
                                </div>

                                <div class="inicio-stock-medida">
                                    <div class="inicio-stock-pista">
                                        <div class="inicio-stock-barra bg-secondary"
                                            style='width: <%#: Eval("AnchoMinimo") %>%'>
                                        </div>
                                    </div>
                                    <span><%#: Eval("StockMinimo") %></span>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <div class="d-flex flex-wrap gap-3 small text-secondary mt-3">
                    <span class="d-flex align-items-center gap-2">
                        <span class="inicio-stock-referencia bg-primary"></span>
                        Actual
    </span>

                    <span class="d-flex align-items-center gap-2">
                        <span class="inicio-stock-referencia bg-secondary"></span>
                        Mínimo
    </span>
                </div>

                <asp:Label ID="lblSinProductos" runat="server"
                    Text="No hay productos activos."
                    CssClass="small text-secondary"
                    Visible="false" />
            </section>
        </div>
        <div class="col-12 col-sm-4">
            <section class="border rounded p-3 h-100 d-flex flex-column justify-content-start bg-light">

                <h2 class="h5 fw-semibold mb-2">💰 Ventas del día</h2>

                <asp:Label ID="lblTotalVentasDia" runat="server"
                    Text="$0,00" CssClass="h2 fw-semibold mb-3" />

                <p class="mb-1">
                    <asp:Label ID="lblCantidadVentasDia" runat="server"
                        Text="0" />
                    ventas confirmadas
                </p>

                <p class="small text-secondary mb-0">
                    Sin incluir anuladas
           
                </p>
            </section>
        </div>

    </div>

    <div class="inicio-modulos px-3">
        <div class="row g-3">

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Productos.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">

                    <span class="fs-3" aria-hidden="true">📦</span>

                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Productos</span>
                        <span class="d-block text-secondary small mt-1">Consultar productos y stock.</span>
                    </span>

                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Marcas.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">

                    <span class="fs-3" aria-hidden="true">🏷️</span>

                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Marcas</span>
                        <span class="d-block text-secondary small mt-1">Crear, editar y cambiar su estado.</span>
                    </span>

                    <span class="text-primary" aria-hidden="true">→</span>
                </a>

            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Categorias.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">
                    <span class="fs-3" aria-hidden="true">🗂️</span>
                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Categorías</span>
                        <span class="d-block text-secondary small mt-1">Organizar los productos del catálogo.</span>
                    </span>
                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Clientes.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">
                    <span class="fs-3" aria-hidden="true">👥</span>
                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Clientes</span>
                        <span class="d-block text-secondary small mt-1">Buscar por DNI y editar datos.</span>
                    </span>
                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Proveedores.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">
                    <span class="fs-3" aria-hidden="true">🚚</span>
                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Proveedores</span>
                        <span class="d-block text-secondary small mt-1">Buscar por razón social o CUIT.</span>
                    </span>
                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Compras.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">
                    <span class="fs-3" aria-hidden="true">🛒</span>
                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Compras</span>
                        <span class="d-block text-secondary small mt-1">Registrar ingresos de mercadería.</span>
                    </span>
                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Ventas.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">
                    <span class="fs-3" aria-hidden="true">💰</span>
                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Ventas</span>
                        <span class="d-block text-secondary small mt-1">Registrar ventas a clientes.</span>
                    </span>
                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Facturas.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">
                    <span class="fs-3" aria-hidden="true">🧾</span>
                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Facturas</span>
                        <span class="d-block text-secondary small mt-1">Consultar comprobantes de venta.</span>
                    </span>
                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

            <div class="col-12 col-sm-6 col-lg-4">
                <a href="Usuarios.aspx"
                    class="inicio-acceso inicio-elevar d-flex align-items-center justify-content-between gap-3 p-3 border rounded text-decoration-none h-100">
                    <span class="fs-3" aria-hidden="true">👤</span>
                    <span class="flex-grow-1">
                        <span class="d-block text-primary fw-semibold fs-6">Usuarios</span>
                        <span class="d-block text-secondary small mt-1">Consultar usuarios y sus roles.</span>
                    </span>
                    <span class="text-primary" aria-hidden="true">→</span>
                </a>
            </div>

        </div>
    </div>
</asp:Content>
