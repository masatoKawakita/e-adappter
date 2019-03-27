class Conversation < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User'
  belongs_to :advertisement
  has_one :conversion, dependent: :destroy
  has_many :messages, dependent: :destroy
  validates_uniqueness_of :advertisement_id, scope: [:sender_id, :recipient_id]

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.sender_id = ? AND conversations.recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
  end

  def target_user(current_user)
    if sender_id == current_user.id
      User.find(recipient_id)
    elsif recipient_id == current_user.id
      User.find(sender_id)
    end
  end

  def CheckRead(current_user)
    notReadMsg = messages.where.not(user_id: current_user.id, read: true)
    notReadMsg.present? ? "#{notReadMsg.length}" : false
  end

  def setCase(current_user)
    tfList = {}
    checkUserType(current_user, tfList)
    checkConversionTable(tfList)
    tfList
  end

  private

  def checkUserType(current_user, tfList)
    tfList['userType'] = true if recipient == current_user
    tfList
  end

  def checkConversionTable(tfList)
    if conversion.present?
      tfList['conversionTable'] = true
      checkTemporaryConfirm(tfList)
      checkDefinitiveConfirm(tfList)
    end
    tfList
  end

  def checkTemporaryConfirm(tfList)
    tfList['temporaryConfirm'] = true if conversion.temporary_confirm
    tfList
  end

  def checkDefinitiveConfirm(tfList)
    tfList['definitiveConfirm'] = true if conversion.definitive_confirm
    tfList
  end
end
