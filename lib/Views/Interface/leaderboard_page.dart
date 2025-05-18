// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Components/empty_state.dart';
import '../../Components/error_message.dart';
import '../../Components/leaderboard_filter.dart';
import '../../Components/leaderboard_item.dart';
import '../../Components/loading_indicator.dart';
import '../../Components/top_performers.dart';
import '../../Providers/leaderboard_provider.dart';
import '../../Utils/auth_validator.dart';
import '../../Utils/connectivity_validator.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> with AutomaticKeepAliveClientMixin {
  bool _isInitialized = false;
  bool _isConnected = true;
  final String _currentUserId = 'user_3'; // Mock current user ID for highlighting

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    // Start listening for connectivity changes
    ConnectivityValidator.startListening(_handleConnectivityChange);
  }
  
  @override
  void dispose() {
    // Stop listening for connectivity changes
    ConnectivityValidator.stopListening();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      // Initialize the provider when the widget is first built
      _initializeProvider();
      _isInitialized = true;
    }
  }

  // Handle connectivity changes
  void _handleConnectivityChange(bool isConnected) {
    if (mounted) {
      setState(() {
        _isConnected = isConnected;
      });
      
      if (isConnected && _isInitialized) {
        // Refresh data when connection is restored
        final provider = Provider.of<LeaderboardProvider>(context, listen: false);
        provider.refreshLeaderboard();
      }
    }
  }

  Future<void> _initializeProvider() async {
    // Check connectivity first
    final isConnected = await ConnectivityValidator.isConnected();
    
    if (!isConnected && mounted) {
      setState(() {
        _isConnected = false;
      });
      
      // Show no connection dialog
      await ConnectivityValidator.showNoConnectionDialog(
        context,
        onRetry: _initializeProvider,
      );
      return;
    }
    
    // Validate if user is authenticated before loading data
    if (await _validateAuthentication()) {
      final provider = Provider.of<LeaderboardProvider>(context, listen: false);
      await provider.initialize();
    }
  }

  // Authentication validation
  Future<bool> _validateAuthentication() async {
    final isAuth = await AuthValidator.isAuthenticated();
    
    if (!isAuth && mounted) {
      // Show authentication required dialog
      await AuthValidator.showAuthRequiredDialog(context);
      return false;
    }
    
    return isAuth;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return ChangeNotifierProvider(
      create: (_) => LeaderboardProvider(),
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 20),
                  _buildFilterSection(),
                  const SizedBox(height: 30),
                  _buildLeaderboardContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Leaderboard",
          style: GoogleFonts.poppins(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Consumer<LeaderboardProvider>(
          builder: (context, provider, _) {
            return IconButton(
              onPressed: provider.isLoading 
                  ? null 
                  : () => provider.refreshLeaderboard(),
              icon: Icon(
                Icons.refresh,
                color: Colors.white.withOpacity(
                  provider.isLoading ? 0.5 : 1.0,
                ),
              ),
              tooltip: 'Refresh leaderboard',
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterSection() {
    return Consumer<LeaderboardProvider>(
      builder: (context, provider, _) {
        return LeaderboardFilter(
          selectedFilter: provider.currentFilter,
          onFilterChanged: (filter) {
            provider.changeFilter(filter);
          },
        );
      },
    );
  }

  Widget _buildLeaderboardContent() {
    // Connectivity validation
    if (!_isConnected) {
      return Expanded(
        child: ErrorMessage(
          message: 'No internet connection. Please check your connection and try again.',
          onRetry: () async {
            final isConnected = await ConnectivityValidator.isConnected();
            if (mounted) {
              setState(() {
                _isConnected = isConnected;
              });
              
              if (isConnected) {
                final provider = Provider.of<LeaderboardProvider>(context, listen: false);
                provider.refreshLeaderboard();
              }
            }
          },
        ),
      );
    }
    
    return Expanded(
      child: Consumer<LeaderboardProvider>(
        builder: (context, provider, _) {
          // Loading state validation
          if (provider.isLoading) {
            return const LoadingIndicator(
              message: 'Loading leaderboard data...',
            );
          }
          
          // Error state validation
          if (provider.error != null) {
            return ErrorMessage(
              message: provider.error!,
              onRetry: () => provider.refreshLeaderboard(),
            );
          }
          
          // Empty state validation
          if (!provider.hasData) {
            return const EmptyState(
              message: 'No leaderboard data available for this time period',
              icon: Icons.emoji_events_outlined,
            );
          }
          
          // Data loaded successfully
          return RefreshIndicator(
            onRefresh: () => provider.refreshLeaderboard(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                // Show top performers section
                if (provider.topPerformers.isNotEmpty)
                  TopPerformers(
                    topEntries: provider.topPerformers,
                    currentUserId: _currentUserId,
                  ),
                
                // Show all entries
                ...provider.entries.map((entry) {
                  final isCurrentUser = entry.userId == _currentUserId;
                  return LeaderboardItem(
                    entry: entry,
                    isCurrentUser: isCurrentUser,
                  );
                }).toList(),
                
                // Add some padding at the bottom
                const SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}
