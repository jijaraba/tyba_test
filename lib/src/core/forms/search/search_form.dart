import 'package:formz/formz.dart';
import 'package:tyba_frotend_engineer_test/src/core/utils/common_extensions.dart';

enum SearchValidation { empty, invalid }

class SearchForm extends FormzInput<String, SearchValidation> {
  const SearchForm.pure() : super.pure('');

  const SearchForm.dirty(String value) : super.dirty(value);

  @override
  SearchValidation? validator(String value) {
    if (value.isEmpty) return SearchValidation.empty;
    return null;
  }
}