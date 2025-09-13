import React from 'react';

type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement> & {
  label?: string;
};

export function Button({ label, children, ...props }: ButtonProps) {
  return (
    <button
      {...props}
      style={{
        padding: '10px 16px',
        borderRadius: 8,
        border: '1px solid #e5e7eb',
        background: '#111827',
        color: '#fff',
        cursor: 'pointer',
        fontSize: 14,
      }}
    >
      {label ?? children}
    </button>
  );
}

