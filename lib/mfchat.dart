library mfchat;

import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:uuid/uuid.dart';

export 'package:intl/intl.dart' hide TextDirection;
export 'package:flutter_parsed_text/flutter_parsed_text.dart';

part 'src/models/chat_message.dart';

part 'src/models/chat_user.dart';

part 'src/chat_view.dart';

part 'src/message_listview.dart';

part 'src/chat_input_toolbar.dart';

part 'src/widgets/message_container.dart';
