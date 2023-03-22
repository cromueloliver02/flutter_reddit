import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../../core/blocs/blocs.dart';
import '../../../../../../core/widgets/widgets.dart';
import '../../../../../community/domain/entities/entities.dart';
import '../../../../../community/presentation/pages/pages.dart';
import '../../../widgets/widgets.dart';

class SearchCommunityDelegate extends SearchDelegate {
  final SearchCommunityBloc _searchCommunityBloc;

  SearchCommunityDelegate({
    required SearchCommunityBloc searchCommunityBloc,
  }) : _searchCommunityBloc = searchCommunityBloc;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox.shrink();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _searchCommunityBloc.add(SearchCommunityRequested(query: query));

    return BlocBuilder<SearchCommunityBloc, SearchCommunityState>(
      bloc: _searchCommunityBloc,
      buildWhen: (prev, curr) => prev.status != curr.status,
      builder: (ctx, state) {
        if (query.isEmpty) {
          return const SearchMessageCard(message: 'SEARCH COMMUNITIES');
        }

        if (state.status == SearchCommunityStatus.loading) {
          return const RDTLoaderCard();
        }

        final List<Community> results = state.results;

        if (state.status == SearchCommunityStatus.success && results.isEmpty) {
          return const SearchMessageCard(message: 'NO COMMUNITIES FOUND');
        }

        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (ctx, idx) {
            final Community community = results[idx];

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(community.avatar),
              ),
              title: Text('r/${community.name}'),
              onTap: () => _goToCommunityDetailsPage(
                context,
                communityId: community.id,
              ),
            );
          },
        );
      },
    );
  }

  void _goToCommunityDetailsPage(
    BuildContext ctx, {
    required String communityId,
  }) {
    Navigator.pop(ctx);
    ctx.goNamed(
      CommunityDetailsPage.name,
      params: {'communityId': communityId},
    );
  }
}
