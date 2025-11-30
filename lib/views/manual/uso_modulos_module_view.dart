import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class UsoModulosModuleView extends StatefulWidget {
  const UsoModulosModuleView({super.key});

  @override
  State<UsoModulosModuleView> createState() => _UsoModulosModuleViewState();
}

class _UsoModulosModuleViewState extends State<UsoModulosModuleView> {
  final List<Map<String, dynamic>> _modules = [
    {
      'id': 'inicio',
      'title': 'Panel de Inicio',
      'description': 'Vista general del sistema',
      'icon': Icons.dashboard,
      'color': Colors.blue,
      'favorite': false,
      'videoAsset': 'videos/panel_inicio.mp4',
      'steps': [
        'Acceda al sistema con sus credenciales',
        'Será redirigido automáticamente al Panel de Inicio',
        'Visualice las tarjetas de resumen (ventas, inventario, etc.)',
        'Use los accesos rápidos para ir a módulos frecuentes',
        'Consulte los gráficos de rendimiento del negocio'
      ]
    },
    {
      'id': 'proveedores',
      'title': 'Proveedores',
      'description': 'Gestión de proveedores',
      'icon': Icons.group,
      'color': Colors.green,
      'favorite': false,
      'videoAsset': 'videos/proveedores.mp4',
      'steps': [
        'Desde el menú, haga clic en "Proveedores"',
        'Para crear: presione el botón "Nuevo Proveedor"',
        'Complete el formulario con datos del proveedor',
        'Para editar: haga clic en el ícono de edición',
        'Para eliminar: use el ícono de eliminar (con confirmación)'
      ]
    },
    // ... (el resto de los módulos se mantienen igual)
    {
      'id': 'compras',
      'title': 'Compras',
      'description': 'Registro de compras',
      'icon': Icons.shopping_cart,
      'color': Colors.orange,
      'favorite': false,
      'videoAsset': 'videos/compras.mp4',
      'steps': [
        'En el menú, despliegue "Compras"',
        'Seleccione "Ver" para listar compras existentes',
        'Seleccione "Crear" para registrar nueva compra',
        'Seleccione proveedor y agregue productos',
        'Confirme la compra y genere el documento'
      ]
    },
    {
      'id': 'clientes',
      'title': 'Clientes',
      'description': 'Administración de clientes',
      'icon': Icons.people,
      'color': Colors.purple,
      'favorite': false,
      'videoAsset': 'videos/clientes.mp4',
      'steps': [
        'Desde el menú, haga clic en "Clientes"',
        'Use el botón "Nuevo Cliente" para registrar',
        'Complete datos personales y de contacto',
        'Use la búsqueda para encontrar clientes rápidamente',
        'Consulte el historial de compras del cliente'
      ]
    },
    {
      'id': 'cajas',
      'title': 'Cajas',
      'description': 'Control de cajas registradoras',
      'icon': Icons.point_of_sale,
      'color': Colors.teal,
      'favorite': false,
      'videoAsset': 'videos/cajas.mp4',
      'steps': [
        'Acceda a "Cajas" desde el menú principal',
        'Para abrir caja: ingrese monto inicial',
        'Registre ventas y otros ingresos/egresos',
        'Al cerrar: el sistema calculará diferencias',
        'Genere reporte de cierre diario'
      ]
    },
    {
      'id': 'ventas',
      'title': 'Ventas',
      'description': 'Proceso de venta',
      'icon': Icons.sell,
      'color': Colors.red,
      'favorite': false,
      'videoAsset': 'videos/ventas.mp4',
      'steps': [
        'En el menú, despliegue "Ventas"',
        'Seleccione "Crear" para nueva venta',
        'Busque y seleccione cliente',
        'Agregue productos al detalle de venta',
        'Seleccione método de pago y finalice'
      ]
    },
    {
      'id': 'productos',
      'title': 'Productos',
      'description': 'Gestión de catálogo',
      'icon': Icons.inventory,
      'color': Colors.indigo,
      'favorite': false,
      'videoAsset': 'videos/productos.mp4',
      'steps': [
        'Despliegue "Productos" en el menú',
        'Use "Gestionar Productos" para listar',
        'Para nuevo producto: botón "Nuevo"',
        'Complete código, nombre, precio, existencias',
        'Asigne categoría, modelo y marca'
      ]
    },
    {
      'id': 'existencias',
      'title': 'Existencias',
      'description': 'Control de inventario',
      'icon': Icons.inventory_2,
      'color': Colors.blueGrey,
      'favorite': false,
      'videoAsset': 'videos/existencias.mp4',
      'steps': [
        'Haga clic en "Existencias" en el menú',
        'Visualice lista de productos con stock',
        'Use filtros para buscar por categoría',
        'Consulte stock mínimo y máximo',
        'Exporte reporte a Excel si es necesario'
      ]
    },
    {
      'id': 'inventario',
      'title': 'Inventario',
      'description': 'Movimientos de kardex',
      'icon': Icons.assignment,
      'color': Colors.brown,
      'favorite': false,
      'videoAsset': 'videos/inventario.mp4',
      'steps': [
        'Acceda a "Inventario" desde el menú',
        'Consulte movimientos de entrada/salida',
        'Filtre por fecha o producto específico',
        'Verifique costos y valores de inventario',
        'Genere reportes de valorización'
      ]
    },
    {
      'id': 'empleados',
      'title': 'Empleados',
      'description': 'Administración de personal',
      'icon': Icons.badge,
      'color': Colors.cyan,
      'favorite': false,
      'videoAsset': 'videos/empleados.mp4',
      'steps': [
        'Desde el menú, haga clic en "Empleados"',
        'Registre nuevo empleado con datos completos',
        'Asigne puesto y departamento',
        'Actualice información cuando sea necesario',
        'Consulte historial laboral'
      ]
    },
    {
      'id': 'usuarios',
      'title': 'Usuarios',
      'description': 'Gestión de usuarios',
      'icon': Icons.person,
      'color': Colors.amber,
      'favorite': false,
      'videoAsset': 'videos/usuarios.mp4',
      'steps': [
        'Acceda a "Usuarios" en el menú',
        'Cree nuevos usuarios del sistema',
        'Asigne contraseña y datos de acceso',
        'Configure permisos y roles',
        'Active/desactive usuarios según necesidad'
      ]
    },
    {
      'id': 'roles',
      'title': 'Roles',
      'description': 'Configuración de permisos',
      'icon': Icons.admin_panel_settings,
      'color': Colors.deepOrange,
      'favorite': false,
      'videoAsset': 'videos/roles.mp4',
      'steps': [
        'Haga clic en "Roles" en el menú',
        'Cree nuevos roles según necesidades',
        'Asigne permisos específicos a cada rol',
        'Asigne roles a usuarios existentes',
        'Pruebe permisos con usuarios de prueba'
      ]
    },
  ];

  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredModules = [];
  String _selectedCategory = 'Todos';
  final List<String> _categories = [
    'Todos',
    'Adquisiciones',
    'Comercialización',
    'Productos e Inventario',
    'Gestión de Usuarios'
  ];

  @override
  void initState() {
    super.initState();
    _filteredModules = _modules;
    _searchController.addListener(_filterModules);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterModules() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredModules = _modules.where((module) {
        final matchesSearch = module['title'].toLowerCase().contains(query) ||
            module['description'].toLowerCase().contains(query);
        
        final matchesCategory = _selectedCategory == 'Todos' || 
            _getModuleCategory(module['id']) == _selectedCategory;
        
        return matchesSearch && matchesCategory;
      }).toList();
    });
  }

  String _getModuleCategory(String moduleId) {
    switch (moduleId) {
      case 'proveedores':
      case 'compras':
        return 'Adquisiciones';
      case 'clientes':
      case 'cajas':
      case 'ventas':
        return 'Comercialización';
      case 'productos':
      case 'existencias':
      case 'inventario':
        return 'Productos e Inventario';
      case 'empleados':
      case 'usuarios':
      case 'roles':
        return 'Gestión de Usuarios';
      default:
        return 'Todos';
    }
  }

  void _toggleFavorite(int index) {
    setState(() {
      _filteredModules[index]['favorite'] = !_filteredModules[index]['favorite'];
      final originalIndex = _modules.indexWhere((module) => module['id'] == _filteredModules[index]['id']);
      if (originalIndex != -1) {
        _modules[originalIndex]['favorite'] = _filteredModules[index]['favorite'];
      }
    });
  }

  void _showVideoPlayer(String videoAsset) {
    // TODO: Implementar reproductor de video
    // Por ahora mostramos un snackbar informativo
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo video: $videoAsset'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showModuleDetail(int index) {
    final module = _filteredModules[index];
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: module['color'].withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: module['color'],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      module['icon'],
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          module['title'],
                          style: AppTextStyles.heading1.copyWith(
                            color: AppColors.textPrimary,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          module['description'],
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _toggleFavorite(index),
                    icon: Icon(
                      module['favorite'] ? Icons.favorite : Icons.favorite_border,
                      color: module['favorite'] ? Colors.red : AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // BOTÓN PARA VER VIDEO EN EL MODAL TAMBIÉN
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () => _showVideoPlayer(module['videoAsset']),
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: const Icon(Icons.play_arrow, size: 20),
                        label: const Text('Ver Video Tutorial'),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Text(
                      'Flujo de Uso - Paso a Paso',
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Expanded(
                      child: ListView.builder(
                        itemCount: module['steps'].length,
                        itemBuilder: (context, stepIndex) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: AppColors.primary.withOpacity(0.1),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${stepIndex + 1}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      module['steps'][stepIndex],
                                      style: AppTextStyles.body.copyWith(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text('Cerrar Guía'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: AppColors.background,
              expandedHeight: 180,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withOpacity(0.9),
                        AppColors.primary,
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.view_module,
                          size: 30,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Uso de los Módulos Principales",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          "Guía completa para utilizar todas las funcionalidades del sistema",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withOpacity(0.9),
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Buscar módulos...',
                                prefixIcon: const Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: AppColors.backgroundVariant,
                              ),
                            ),
                            const SizedBox(height: 12),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: _categories.map((category) {
                                  final isSelected = _selectedCategory == category;
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      label: Text(
                                        category,
                                        style: TextStyle(
                                          color: isSelected ? Colors.white : AppColors.textPrimary,
                                        ),
                                      ),
                                      selected: isSelected,
                                      onSelected: (selected) {
                                        setState(() {
                                          _selectedCategory = category;
                                          _filterModules();
                                        });
                                      },
                                      backgroundColor: Colors.white,
                                      selectedColor: AppColors.primary,
                                      checkmarkColor: Colors.white,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    _buildModulesGrid(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModulesGrid() {
    if (_filteredModules.isEmpty) {
      return Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              Icon(
                Icons.search_off,
                size: 50,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                'No se encontraron módulos',
                style: AppTextStyles.heading2.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Intenta con otros términos de búsqueda',
                style: AppTextStyles.body.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.9, // Optimizado para móvil
      ),
      itemCount: _filteredModules.length,
      itemBuilder: (context, index) {
        final module = _filteredModules[index];
        return _buildModuleCard(module, index);
      },
    );
  }

  Widget _buildModuleCard(Map<String, dynamic> module, int index) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _showModuleDetail(index),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // HEADER CON ICONO Y FAVORITO - MÁS COMPACTO
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: module['color'].withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      module['icon'],
                      color: module['color'],
                      size: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _toggleFavorite(index),
                    child: Icon(
                      module['favorite'] ? Icons.favorite : Icons.favorite_border,
                      color: module['favorite'] ? Colors.red : AppColors.textSecondary,
                      size: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              
              // CONTENIDO DE TEXTO - MÁS COMPACTO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module['title'],
                      style: AppTextStyles.heading2.copyWith(
                        color: AppColors.textPrimary,
                        fontSize: 12,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      module['description'],
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.textSecondary,
                        fontSize: 9,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 8),
              
              // BOTONES EN COLUMNA COMPACTA
              Column(
                children: [
                  // BOTÓN VER VIDEO
                  SizedBox(
                    width: double.infinity,
                    height: 28, // Altura fija para consistencia
                    child: FilledButton.icon(
                      onPressed: () => _showVideoPlayer(module['videoAsset']),
                      style: FilledButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow, size: 12),
                      label: const Text(
                        'Video',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  
                  // BOTÓN VER DETALLE
                  SizedBox(
                    width: double.infinity,
                    height: 28, // Misma altura que el botón de video
                    child: OutlinedButton(
                      onPressed: () => _showModuleDetail(index),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        side: BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text(
                        'Detalle',
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}