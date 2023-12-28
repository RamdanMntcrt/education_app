import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/size_config.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool homeBar;

  final String title;
  final Widget? actionIcon;

  const CustomAppBar(
      {Key? key, required this.title, this.actionIcon, required this.homeBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: SizeConfig.blockSizeHorizontal * 5,
          right: SizeConfig.blockSizeHorizontal * 5,
          top: SizeConfig.blockSizeHorizontal * 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          !homeBar
              ? SizedBox(
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: SizeConfig.blockSizeHorizontal * 11,
                      width: SizeConfig.blockSizeHorizontal * 11,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                      child: const Icon(
                        CupertinoIcons.left_chevron,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : Container(),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal * 50,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                    overflow: TextOverflow.visible,
                    fontSize: SizeConfig.blockSizeHorizontal * 5,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          actionIcon == null
              ? SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 10,
                )
              : SizedBox(
                  width: SizeConfig.blockSizeHorizontal * 10,
                  child: actionIcon!)
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize =>
      Size.fromHeight(SizeConfig.blockSizeHorizontal * 15);
}
