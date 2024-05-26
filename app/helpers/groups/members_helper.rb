# frozen_string_literal: true

module Groups
  module MembersHelper
    def toggle_button(current_user, membership, attribute)
      return if current_user == membership.user

      button_to(
        group_member_path(membership.group, membership.user),
        method: :patch,
        params: { membership: { attribute => !membership.public_send(attribute) } },
        data: { turbo_submits_with: '送信中...' },
        role: 'switch',
        'aria-checked': membership.public_send(attribute).to_s,
        class: toggle_button_class(membership.public_send(attribute))
      ) do
        tag.span('', aria: { hidden: true }, class: toggle_span_class(membership.public_send(attribute)))
      end
    end

    def toggle_button_class(active)
      base_class = %w[relative inline-flex h-5 w-8 shrink-0 cursor-pointer
                      appearance-none rounded-full border-2 border-transparent transition
                      focus:outline-none focus:ring focus:ring-blue-200]
      base_class << (active ? 'bg-blue-700' : 'bg-gray-200')
    end

    def toggle_span_class(active)
      base_class = %w[pointer-events-none inline-block h-4 w-4
                      rounded-full bg-white transition will-change-transform]
      base_class << (active ? 'translate-x-3' : 'translate-x-0')
    end
  end
end
