import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tobeto/src/common/constants/assets.dart';
import 'package:tobeto/src/common/enums/user_rank_enum.dart';

import '../../blocs/auth/auth_bloc.dart';

class TBTSliverAppBar extends StatelessWidget {
  const TBTSliverAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: true,
      floating: true,
      snap: true,
      title: Image.asset(
        Assets.imagesTobetoLogo,
        width: 200,
      ),
      actions: [
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is Authenticated &&
                (state.userModel.userRank == UserRank.admin ||
                    state.userModel.userRank == UserRank.instructor)) {
              return IconButton(
                onPressed: () => Scaffold.of(context).openEndDrawer(),
                icon: const Icon(Icons.admin_panel_settings_outlined),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
    );
  }
}
