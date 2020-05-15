library mfchat;

import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:flutter_parsed_text/flutter_parsed_text.dart';

export 'package:intl/intl.dart' hide TextDirection;
export 'package:flutter_parsed_text/flutter_parsed_text.dart';


part 'src/models/chat_message.dart';
part 'src/models/chat_user.dart';
part 'src/chat_view.dart';
part 'src/message_listview.dart';
part 'src/chat_input_toolbar.dart';
part 'src/widgets/avatar_container.dart';
part 'src/widgets/custom_scroll_behaviour.dart';
part 'src/widgets/load_earlier.dart';
part 'src/widgets/message_container.dart';
part 'src/widgets/scroll_to_bottom.dart';