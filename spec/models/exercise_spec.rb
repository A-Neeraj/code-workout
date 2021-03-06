# == Schema Information
#
# Table name: exercises
#
#  id                     :integer          not null, primary key
#  experience             :integer          not null
#  is_public              :boolean          default(FALSE), not null
#  name                   :string(255)
#  question_type          :integer          not null
#  versions               :integer
#  created_at             :datetime
#  updated_at             :datetime
#  current_version_id     :integer
#  exercise_collection_id :integer
#  exercise_family_id     :integer
#  external_id            :string(255)
#  irt_data_id            :integer
#
# Indexes
#
#  exercises_irt_data_id_fk                   (irt_data_id)
#  index_exercises_on_current_version_id      (current_version_id)
#  index_exercises_on_exercise_collection_id  (exercise_collection_id)
#  index_exercises_on_exercise_family_id      (exercise_family_id)
#  index_exercises_on_external_id             (external_id) UNIQUE
#  index_exercises_on_is_public               (is_public)
#
# Foreign Keys
#
#  exercises_current_version_id_fk  (current_version_id => exercise_versions.id)
#  exercises_exercise_family_id_fk  (exercise_family_id => exercise_families.id)
#  exercises_irt_data_id_fk         (irt_data_id => irt_data.id)
#

require 'spec_helper'

describe Exercise do
  before :all do
    @exercise = Exercise.find(1)
  end

  describe 'creator edit permissions' do
    it 'should be editable by the exercise creator' do
      user = @exercise.current_version.andand.creator
      expect(user.can?(:edit, @exercise)).to eq(true)
    end
  end
end
